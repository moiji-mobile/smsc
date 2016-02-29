as yet unclassified
exampleEncodedMessage
	| smppMessage |
	smppMessage := SMPPMessage readFrom: SMPPMessageTest new exampleDeliverSM readStream.
	^smppMessage body toMessage asByteArray