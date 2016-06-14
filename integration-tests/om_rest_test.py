#    runs integration tests against the osmo-smsc restapi
#    Copyright (C) 2016  Henning Heinold <henning@itconsulting-heinold.de>
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU Affero General Public License as
#    published by the Free Software Foundation, either version 3 of the
#    License, or (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU Affero General Public License for more details.
#
#    You should have received a copy of the GNU Affero General Public License
#    along with this program.  If not, see <http://www.gnu.org/licenses/>.


import pytest
from operator import itemgetter

CLIENT_NAME = "client"
SERVER_NAME = "server"

def client_data():
    return {"connectionType": CLIENT_NAME,
            "hostname": "127.0.0.1",
            "port": 88,
            "systemId": "systemId",
            "systemType": "systemType",
            "password": "password",
            "role" : None}

def server_data():
    return {"connectionType": SERVER_NAME,
            "systemType": "systemType",
            "allowedRemotePort": 99,
            "allowedRemoteAddress": "127.0.0.1",
            "password": "password",
            "port": 99,
            "role": None,
            "systemId": "systemId"}

@pytest.fixture
def client_entry(om_rest_api):
    test_data = client_data()
    om_rest_api(CLIENT_NAME).put(data=test_data)
    return test_data

@pytest.fixture
def server_entry(om_rest_api):
    test_data = server_data()
    om_rest_api(SERVER_NAME).put(data=test_data)
    return test_data

@pytest.fixture
def collection_entries(client_entry, server_entry):
    return [client_entry, server_entry]

@pytest.mark.usefixtures("om_image")
class TestOM:

    def test_client_insert(self, client_entry, om_rest_api):
        rest_answer = om_rest_api(CLIENT_NAME).get()

        assert len(rest_answer)-1 == len(client_entry)

        for key in client_entry:
            assert rest_answer[key] == client_entry[key]

        assert rest_answer['connectionName'] == CLIENT_NAME

    def test_server_insert(self, server_entry, om_rest_api):
        rest_answer = om_rest_api(SERVER_NAME).get()

        assert len(rest_answer)-1 == len(server_entry)

        for key in server_entry:
            assert rest_answer[key] == server_entry[key]

        assert rest_answer['connectionName'] == SERVER_NAME

    def test_collection_api(self, collection_entries, om_rest_collection_api):
        rest_answer = om_rest_collection_api.get()

        assert len(rest_answer) == 2
        sorted_answer = sorted(rest_answer, key=itemgetter('connectionName'))

        assert sorted_answer[0]['connectionName'] == CLIENT_NAME
        assert sorted_answer[1]['connectionName'] == SERVER_NAME

    def test_client_update(self, client_entry, om_rest_api):
        client_entry['port'] = 99
        om_rest_api(CLIENT_NAME).put(data=client_entry)
        client_answer = om_rest_api(CLIENT_NAME).get()
        assert client_answer['port'] == 99

    def test_server_update(self, server_entry, om_rest_api):
        server_entry['allowedRemotePort'] = 101
        om_rest_api(SERVER_NAME).put(data=server_entry)
        server_answer = om_rest_api(SERVER_NAME).get()
        assert server_answer['allowedRemotePort'] == 101
