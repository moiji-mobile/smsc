tests-forward
testFormatMessage
	| forwarder formatedMessage parsedMessage |
	forwarder := ShortMessageDeliveryForwardSMv2 new.
	forwarder messages: {
		{ 'encodedMessage' -> self exampleEncodedMessage.
		  'encodedMessageType' -> 'SMPPDeliverSM'. } asDictionary}.
	forwarder instVarNamed: #pendingMessages put: (forwarder instVarNamed: #messages) copy.

	formatedMessage := forwarder formatMessage.
	parsedMessage := ShortMessageTPDUHelper extractDeliverFrom: formatedMessage readStream.
	self assert: formatedMessage class equals: ByteArray.
	self assert: (parsedMessage at: 'TP-OA') equals: '888817024782276'.