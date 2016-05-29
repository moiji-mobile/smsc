#    runs integration tests against the osmo-smsc delivery
#    Copyright (C) 2016 Holger Hans Peter Freyther <holger@freyther.de>
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
import socket

@pytest.mark.usefixtures("smsc_delivery_image")
class TestDelivery:

    def testLinkUp(self):
        smppSocket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        smppSocket.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
        smppSocket.bind(('localhost', 8888))
        smppSocket.listen(1)
        smppSocket.setblocking(1)

        ss7Socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        ss7Socket.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
        ss7Socket.bind(('localhost', 9999))
        ss7Socket.listen(1)
        ss7Socket.setblocking(1)

        # wait for connection
        (s, _) = smppSocket.accept()
        s.close()
        (s, _) = ss7Socket.accept()
        s.close()

        # and wait again
        (s, _) = smppSocket.accept()
        s.close()
        (s, _) = ss7Socket.accept()
        s.close()
