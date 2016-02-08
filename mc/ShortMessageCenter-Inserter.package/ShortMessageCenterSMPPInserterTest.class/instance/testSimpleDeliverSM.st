as yet unclassified
testSimpleDeliverSM
	| message |
	message := SMPPMessage readFrom: SMPPMessageTest new exampleDeliverSM readStream.
	smscInserter smppCommand: message from: mockConnection handler.