import pytest
import tortilla

def pytest_addoption(parser):
    parser.addoption("--om-server", action="store", default="localhost",
        help="dns name or IP of the osmo-smsc-om server")
    parser.addoption("--om-server-port", action="store", default=1700,
        help="dns name or IP of the osmo-smsc-om server")

    parser.addoption("--inserter-server", action="store", default="localhost",
        help="dns name or IP of the osmo-smsc-inserter server")
    parser.addoption("--inserter-server-port", action="store", default=1700,
        help="Port where the osmo-smsc-inserter server runs")
    parser.addoption("--inserter-system-id", action="store", default="system_id",
        help="The system id set into the om inserterlink")
    parser.addoption("--inserter-password", action="store", default="password",
        help="The password set into the om inserterlink")

    parser.addoption("--inserter-client", action="store", default="localhost",
        help="dns name or IP of the osmo-smsc-inserter client")
    parser.addoption("--inserter-client-port", action="store", default=1700,
        help="Port where the osmo-smsc-inserter client runs")

    parser.addoption("--mongodb-server", action="store", default="localhost",
        help="dns name or IP of the mongodb server")
    parser.addoption("--mongodb-server-port", action="store", default=27017,
        help="Port where the mongodb server runs")


@pytest.fixture(scope="session")
def om_server(request):
    return request.config.getoption("--om-server")

@pytest.fixture(scope="session")
def om_server_port(request):
    return request.config.getoption("--om-server-port")

@pytest.fixture(scope="session")
def inserter_server(request):
    return request.config.getoption("--inserter-server")

@pytest.fixture(scope="session")
def inserter_server_port(request):
    return request.config.getoption("--inserter-server-port")

@pytest.fixture(scope="session")
def inserter_system_id(request):
    return request.config.getoption("--inserter-system-id")

@pytest.fixture(scope="session")
def inserter_password(request):
    return request.config.getoption("--inserter-password")

@pytest.fixture(scope="session")
def inserter_client(request):
    return request.config.getoption("--inserter-client")

@pytest.fixture(scope="session")
def inserter_client_port(request):
    return request.config.getoption("--inserter-client-port")

@pytest.fixture(scope="session")
def mongodb_server(request):
    return request.config.getoption("--mongodb-server")

@pytest.fixture(scope="session")
def mongodb_server_port(request):
    return request.config.getoption("--mongodb-server-port")


@pytest.fixture(scope="session")
def om_rest_api(om_server, om_server_port):
    api = tortilla.wrap('http://{}:{}/v1/inserterSMPPLink'.format(om_server, om_server_port), format='json')
    api.config.headers = {'Content-Type': 'application/json'}
    return api

@pytest.fixture(scope="session")
def om_rest_collection_api(om_server, om_server_port):
    return tortilla.wrap('http://{}:{}/v1/inserterSMPPLinks'.format(om_server, om_server_port), format='json')

