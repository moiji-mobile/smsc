as yet unclassified
testNoReponseToBigSMSForwardSM

	| forwarder central mockDatabase |
	mockDatabase := ShortMessageDeliveryMockDatabase new.
	central := ShortMessageCenterDeliveryCentral new.
	central instVarNamed: #tcapLinks put: { 'test' -> smscEndPoint  } asDictionary.
	forwarder := ShortMessageDeliveryForwardSMv2 new.
	forwarder
		timerM: 0.1;
		maxSMRPUISize: 1;
		smscDatabase: mockDatabase;
		connectionName: 'test';
		deliveryCentral: central;
		smscNumber: '66666';
		globalTitle: '66666';
		ssn: 7;
		messages: {{ '_id' -> '1234'. 'destMSISDN' -> '491667334522'. 'encodedMessage' -> self exampleEncodedMessage. 'encodedMessageType' -> 'SMPPDeliverSM'. } asDictionary} asOrderedCollection.
		
	"Return a valid result but then disconnect the network"
	testEndPoint
		onDialogue: [:diag |
			diag onInvoke: [:tcapNotify |
					| result |
					"Disconnect smscEndPoint to skip forwardSM"
					smscEndPoint networkService autoDispatch: false.
					result := tcapNotify newResultValue.
					result at: 'imsi' put: '1234' toTBCD.
					(result expandFieldNamed: 'locationInfoWithLMSI')
						at: 'networkNode-Number' put: '4321' toE164.
					tcapNotify returnResultLast: result.
					diag requestTcEnd: false]].

	forwarder blockingExecute.
	self assert: mockDatabase operations size equals: 1.
	self assert: mockDatabase operations first key equals: #deliveryAttempt.
	self assert: mockDatabase operations first value equals: '1234'.

	self assert: smscEndPoint dialoguesAndTransactions size equals: 0.