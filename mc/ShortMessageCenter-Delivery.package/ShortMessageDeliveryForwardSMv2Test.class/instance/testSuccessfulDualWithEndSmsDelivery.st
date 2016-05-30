as yet unclassified
testSuccessfulDualWithEndSmsDelivery
	| forwarder central mapReqSRI mapReqFwd mockDatabase |
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
		messages: {
			{ '_id' -> '1234'. 'destMSISDN' -> '491667334522'. 'encodedMessage' -> self exampleEncodedMessage. 'encodedMessageType' -> 'SMPPDeliverSM'. } asDictionary.
			{ '_id' -> '45678'. 'destMSISDN' -> '491667334522'. 'encodedMessage' -> self exampleEncodedMessage. 'encodedMessageType' -> 'SMPPDeliverSM'. } asDictionary.} asOrderedCollection.
		
	"Configure our response script"
	testEndPoint
		onDialogue: [:diag |
			diag onInvoke: [:tcapNotify |
				| isSRIForSM isFwdSM result |
				isSRIForSM := tcapNotify invocation operationName = 'sendRoutingInfoForSMV2'.
				isFwdSM := tcapNotify invocation operationName = 'forwardSM'.
				isSRIForSM ifTrue: [
					mapReqSRI := tcapNotify invocation.
					result := mapReqSRI newResultValue.
					result at: 'imsi' put: '1234' toTBCD.
					(result expandFieldNamed: 'locationInfoWithLMSI')
						at: 'networkNode-Number' put: '4321' toE164.
					tcapNotify returnResultLast: result.
					diag requestTcEnd: false].
				isFwdSM ifTrue: [
					mapReqFwd := tcapNotify invocation.
					tcapNotify returnResultLast: nil.
					diag requestTcEnd: false]]].		
		

	forwarder blockingExecute.
	self assert: mockDatabase operations size equals: 2.
	self assert: mockDatabase operations first key equals: #remove.
	self assert: mockDatabase operations first value equals: '1234'.
	self assert: mockDatabase operations second key equals: #remove.
	self assert: mockDatabase operations second value equals: '45678'.

	self assert: smscEndPoint dialoguesAndTransactions size equals: 0.