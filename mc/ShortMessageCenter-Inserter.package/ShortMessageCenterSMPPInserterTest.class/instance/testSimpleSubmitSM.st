as yet unclassified
testSimpleSubmitSM
	| message |
	message := SMPPMessage readFrom: SMPPMessageTest new exampleSubmitSM readStream.
	smscInserter smppCommand: message from: mockConnection handler.