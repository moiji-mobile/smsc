import pytest
import tortilla
import os
import subprocess
from pymongo import MongoClient

def pytest_addoption(parser):
    parser.addoption("--pharo-vm", action="store", default="pharo",
        help="Pharo VM name")
    parser.addoption("--pharo-image", action="store", default="OsmoSmsc.image",
        help="Smalltalk image to use")
    parser.addoption("--image-launch", action="store",
        default="/usr/share/image-launch/bootstrap.st", help="Image launch")


@pytest.fixture(scope="session")
def mongo_client():
    mongo_dbhost = "127.0.0.1:27017"
    return MongoClient([mongo_dbhost])

@pytest.fixture(scope="session")
def om_server(request):
    return "localhost"

@pytest.fixture(scope="session")
def om_server_port(request):
    return 1700

@pytest.fixture(scope="session")
def om_rest_api(om_server, om_server_port):
    api = tortilla.wrap('http://{}:{}/v1/inserterSMPPLink'.format(om_server, om_server_port), format='json')
    api.config.headers = {'Content-Type': 'application/json'}
    return api

@pytest.fixture
def om_database(mongo_client):
    """Drop the database to start with a fresh one"""
    name = "om-test"
    print("Dropping database %s" % name)
    mongo_client.drop_database(name)
    return name

@pytest.fixture
def smsc_database(mongo_client):
    """Drop the database to start with a fresh one"""
    name = "smsc-test"
    print("Dropping database %s" % name)
    mongo_client.drop_database(name)
    return name

@pytest.fixture(scope="session")
def om_rest_collection_api(om_server, om_server_port):
    return tortilla.wrap('http://{}:{}/v1/inserterSMPPLinks'.format(om_server, om_server_port), format='json')

def waitForPort(port):
    """Linux specific to listen"""
    port_str = ":%.4X 00000000:0000" % port
    while True:
        with open("/proc/net/tcp", "r") as f:
            c = f.read()
            if port_str in c:
                print("Listening now..")
                return None
        import time
        time.sleep(1)

def launch_image(request, files, extra_args):
    pharo_vm = request.config.getoption("--pharo-vm")
    pharo_image = request.config.getoption("--pharo-image")
    image_launch = request.config.getoption("--image-launch")
    cmd = [
                pharo_vm,
                "--nodisplay", pharo_image, image_launch,
                "--imagelaunch-dir=" + os.path.join(os.path.abspath(os.path.dirname(__file__)), "files/" + files + "/")] + extra_args

    print("Starting %s" % " ".join(cmd))
    proc = subprocess.Popen(cmd)
    def stop_process():
        print("Killing %s" % files)
        proc.kill()
        proc.wait()
    request.addfinalizer(stop_process)
    return proc


@pytest.fixture
def om_image(om_database, smsc_database, request):
    """Start a image and have a fresh database ready"""
    proc = launch_image(request, "om", ["--smscdb-name=" + smsc_database, "--omdb-name=" + om_database])
    waitForPort(1700)
    return proc

@pytest.fixture
def smsc_inserter_image(om_database, smsc_database, om_image, om_rest_api, request):
    """Start SMSC inserter"""
    # Configure a link that will listen for our data
    om_rest_api("serverLink").put(data={
                                        "connectionType" : "server",
                                        "port": 9000,
                                        "systemId": "inserter-test",
                                        "systemType": "systemType",
                                        "password": "pass",
                                        "allowedRemoteAddress": None,
                                        "allowedRemotePort": None})
    proc = launch_image(request, "inserter", ["--smscdb-name=" + smsc_database, "--omdb-name=" + om_database])
    waitForPort(9000)
    return proc

@pytest.fixture
def smsc_delivery_image(om_database, smsc_database, om_image, om_server, om_server_port, request):
    """Start the delivery image with a SS7 link and a SMPP link"""
    smppLink = tortilla.wrap('http://{}:{}/v1/deliverySMPPLink'.format(om_server, om_server_port), format='json')
    ss7Link = tortilla.wrap('http://{}:{}/v1/deliverySS7Link'.format(om_server, om_server_port), format='json')

    smppLink("smppClientLink").put(data={
                                        "connectionType" : "client",
                                        "hostname": "localhost",
                                        "port": 8888,
                                        "systemId": "inserter-test",
                                        "systemType": "systemType",
                                        "password": "pass"})
    ss7Link("ss7ClientLink").put(data={
                                        "hostname": "localhost",
                                        "port": 9999,
                                        "token": "test"})
    proc = launch_image(request, "delivery", ["--smscdb-name=" + smsc_database, "--omdb-name=" + om_database])
