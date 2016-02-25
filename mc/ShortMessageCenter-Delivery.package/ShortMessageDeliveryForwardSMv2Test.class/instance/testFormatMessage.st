tests-forward
testFormatMessage
	| forwarder smppMessage formatedMessage parsedMessage |
	smppMessage := SMPPMessage readFrom: SMPPMessageTest new exampleDeliverSM readStream.
	forwarder := ShortMessageDeliveryForwardSMv2 new.
	forwarder messages: {
		{ 'encodedMessage' -> smppMessage body toMessage asByteArray } asDictionary}.
	forwarder instVarNamed: #pendingMessages put: (forwarder instVarNamed: #messages) copy.

	formatedMessage := forwarder formatMessage.
	parsedMessage := ShortMessageTPDUHelper extractDeliverFrom: formatedMessage readStream.
	self assert: formatedMessage class equals: ByteArray.
	self assert: (parsedMessage at: 'TP-OA') equals: '888817024782276'.