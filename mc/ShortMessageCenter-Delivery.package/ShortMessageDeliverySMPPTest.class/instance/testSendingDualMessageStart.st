as yet unclassified
testSendingDualMessageStart
	| mockDatabase central smppMockConnection forwarder |
	mockDatabase := ShortMessageDeliveryMockDatabase new.
	smppMockConnection := SMPPMockConnection new.
	smppMockConnection connectionName: 'testSmpp'.
	central := ShortMessageCenterDeliveryCentral new.
	central instVarNamed: #smppDeliveryLinks put: { smppMockConnection }.
	forwarder := ShortMessageDeliveryMethodSMPP new
						connectionName: 'testSmpp';
						messageType: 'deliverSM';
						createDelivery.
	forwarder
		smscDatabase: mockDatabase;
		deliveryCentral: central;
		messages: {
			{ '_id' -> '1234'. 'destMSISDN' -> '491667334522'. 'encodedMessage' -> self exampleEncodedMessage. 'encodedMessageType' -> 'SMPPDeliverSM' } asDictionary.
			{ '_id' -> '45678'. 'destMSISDN' -> '491667334522'. 'encodedMessage' -> self exampleEncodedSubmitMessage. 'encodedMessageType' -> 'SMPPSubmitSM' } asDictionary.} asOrderedCollection.
	forwarder blockingExecute.

	self assert: forwarder class equals: ShortMessageDeliverySMPPDeliverSM.
	self assert: mockDatabase operations size equals: 2.
	self assert: mockDatabase operations first key equals: #remove.
	self assert: mockDatabase operations first value equals: '1234'.
	self assert: mockDatabase operations second key equals: #remove.
	self assert: mockDatabase operations second value equals: '45678'.
	self assert: forwarder pendingMessages size equals: 0.

	self assert: smppMockConnection scheduledCommands size equals: 2.