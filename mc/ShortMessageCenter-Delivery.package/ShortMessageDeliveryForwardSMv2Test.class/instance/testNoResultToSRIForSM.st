as yet unclassified
testNoResultToSRIForSM

	| forwarder central mockDatabase |
	mockDatabase := ShortMessageDeliveryMockDatabase new.
	central := ShortMessageCenterDeliveryCentral new.
	central instVarNamed: #tcapLinks put: { 'test' -> smscEndPoint  } asDictionary.
	forwarder := ShortMessageDeliveryForwardSMv2 new.
	forwarder
		smscDatabase: mockDatabase;
		connectionName: 'test';
		deliveryCentral: central;
		smscNumber: '66666';
		globalTitle: '66666';
		ssn: 7;
		messages: {{ '_id' -> '1234'. 'destMSISDN' -> '491667334522'. 'encodedMessage' -> self exampleEncodedMessage. 'encodedMessageType' -> 'SMPPDeliverSM'. } asDictionary} asOrderedCollection.
		
	"Return a ROS result but no data"
	testEndPoint
		onDialogue: [:diag |
			diag onInvoke: [:tcapNotify |
					tcapNotify returnResultLast: nil.
					diag requestTcEnd: false]].

	forwarder blockingExecute.
	self assert: mockDatabase operations size equals: 1.
	self assert: mockDatabase operations first key equals: #deliveryAttempt.
	self assert: mockDatabase operations first value equals: '1234'.