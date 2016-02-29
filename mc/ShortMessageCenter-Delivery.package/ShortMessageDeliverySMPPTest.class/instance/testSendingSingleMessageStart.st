as yet unclassified
testSendingSingleMessageStart
	| mockDatabase central smppMockConnection forwarder |
	mockDatabase := ShortMessageDeliveryMockDatabase new.
	smppMockConnection := SMPPMockConnection new.
	smppMockConnection connectionName: 'testSmpp'.
	central := ShortMessageCenterDeliveryCentral new.
	central instVarNamed: #smppDeliveryLinks put: { smppMockConnection }.
	forwarder := ShortMessageDeliverySMPP new.
	forwarder
		smscDatabase: mockDatabase;
		connectionName: 'testSmpp';
		deliveryCentral: central;
		messages: {{ '_id' -> '1234'. 'destMSISDN' -> '491667334522'. 'encodedMessage' -> self exampleEncodedMessage } asDictionary} asOrderedCollection.
	forwarder blockingExecute.

	self assert: mockDatabase operations size equals: 1.
	self assert: mockDatabase operations first key equals: #remove.
	self assert: mockDatabase operations first value equals: '1234'.