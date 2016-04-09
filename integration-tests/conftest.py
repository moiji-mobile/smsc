import pytest

def pytest_addoption(parser):
    parser.addoption("--om-server", action="store", default="localhost",
        help="dns name or IP of the osmo-smsc-om server")
    parser.addoption("--om-server-port", action="store", default=1700,
        help="dns name or IP of the osmo-smsc-om server")

@pytest.fixture
def om_server(request):
    return request.config.getoption("--om-server")

@pytest.fixture
def om_server_port(request):
    return request.config.getoption("--om-server-port")
