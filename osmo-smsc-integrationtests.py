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


import tortilla
import argparse
import sys

def test_inserter(host, port):
    inserter_collection_api = tortilla.wrap('http://{}:{}/v1/inserterSMPPLinks'.format(host, port), format='json')
    inserter_api = tortilla.wrap('http://{}:{}/v1/inserterSMPPLink'.format(host, port), format='json')
    inserter_api.config.headers = {'Content-Type': 'application/json'}

    client={"connectionType": "client",
          "hostname": "127.0.0.1",
          "port": 88,
          "systemId": "systemId",
          "systemType": "systemType",
          "password": "password"}
    server={"connectionType": "server",
          "port": 99,
          "systemId": "systemId",
          "systemType": "systemType",
          "password": "password",
          "allowedRemoteAddress": "127.0.0.1",
          "allowedRemotePort": 99}

    inserter_api("client").put(data=client)
    inserter_api("client").get()
    inserter_api("server").put(data=server)
    inserter_api("server").get()
    inserter_collection_api.get()

    # test update
    client['port'] = 99
    inserter_api("client").put(data=client)
    client_answer = inserter_api("client").get()
    if not client_answer['port'] == 99:
        sys.exit(1)

    server['allowedRemotePort'] = 101
    inserter_api("server").put(data=server)
    server_answer = inserter_api("server").get()
    if not server_answer['allowedRemotePort'] == 101:
        sys.exit(1)

    inserter_api("client").delete()
    inserter_api("server").delete()

def check_arg(args=None):
    parser = argparse.ArgumentParser(description='runs integration tests against the osmo-smsc restapi')
    parser.add_argument('-H', '--host',
                        help='host ip',
                        default='localhost')
    parser.add_argument('-p', '--port',
                        help='port of the rest api server',
                        default='1700')

    results = parser.parse_args(args)
    return (results.host,
            results.port)

def main():
    host, port = check_arg(sys.argv[1:])
    test_inserter(host, port)

main()
