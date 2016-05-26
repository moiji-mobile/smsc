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
import sys

import smpplib.gsm
import smpplib.client
import smpplib.consts

from pymongo import MongoClient


@pytest.fixture
def smpp_client(request, inserter_server, inserter_server_port, inserter_system_id, inserter_password):

    client = smpplib.client.Client(inserter_server, inserter_server_port)

    def disconnect_client():
        client.unbind()
        client.disconnect()

    request.addfinalizer(disconnect_client)

    # Print when obtain message_id
    client.set_message_received_handler(
        lambda pdu: sys.stdout.write('delivered {}\n'.format(pdu.receipted_message_id)))

    client.connect()
    client.bind_transceiver(system_id=inserter_system_id, password=inserter_password)

    return client

@pytest.fixture
def mongo_client(request, mongodb_server, mongodb_server_port):

    mongo_dbhost = "%s:%s" % (mongodb_server, mongodb_server_port)
    client = MongoClient([mongo_dbhost])

    def delete_smsc_db():
        client.drop_database("smsc")
        print ("finalizing mongodb")

    request.addfinalizer(delete_smsc_db)

    return client

def send_message(source, destination, message, smpp_client):

    # be some form of mutable to be accessible by the inner function
    sent = {'sent': 0}
    parts, encoding_flag, msg_type_flag = smpplib.gsm.make_parts(message)

    for part in parts:
        smpp_client.send_message(
            source_addr_ton=smpplib.consts.SMPP_TON_INTL,
            source_addr_npi=smpplib.consts.SMPP_NPI_ISDN,
            source_addr=source,
            dest_addr_ton=smpplib.consts.SMPP_TON_INTL,
            dest_addr_npi=smpplib.consts.SMPP_NPI_ISDN,
            destination_addr=destination,
            short_message=part,
            data_coding=encoding_flag,
            #esm_class=msg_type_flag,
            esm_class=smpplib.consts.SMPP_MSGMODE_FORWARD,
            registered_delivery=False,
        )

    def sent_message(pdu):
        """
        Once we have receive the number of callbacks expected, let's break
        out the listen loop that was entered below. With more time we can
        have a better approach.
        """
        sent['sent'] = sent['sent'] + 1
        if len(parts) == sent['sent']:
            raise Exception("Break the loop")

    smpp_client.set_message_sent_handler(sent_message)
    try:
        smpp_client.listen()
    except:
        pass

@pytest.fixture
def sms_parts(smpp_client):

    source = '3009'
    destination = '3110'
    message = 'Hello'

    send_message(source, destination, message, smpp_client)

    return source, destination, message

def test_inserter_server(sms_parts, mongo_client):

    source, destination, message = sms_parts

    # database will be create when send_message is called
    db = mongo_client.smsc

    assert db.smsQueue.count() == 1

    cursor = db.smsQueue.find()

    for sms in cursor:
        assert sms['sourceMSISDN'] == source
        assert sms['destMSISDN'] == destination
        assert sms['encodedMessageType'] == 'SMPPSubmitSM'
