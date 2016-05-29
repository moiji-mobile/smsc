tests-as yet unclassified
testSendMessagesUnroutable
	| messages |
	worker smscDatabase
		insertShortMessage: SMPPMessageTest new exampleDeliverSM messageType: '123' destination: '1234567890' source: '1234' deliverIn: 0 seconds expireIn: 10 days receivedOn: 'link1';
		insertShortMessage: SMPPMessageTest new exampleDeliverSM messageType: '123' destination: '1234567890' source: '1234' deliverIn: 0 seconds expireIn: 10 days receivedOn: 'link1'.
 
	messages := worker messagesSelector selectMessages.
	self assert: messages size equals: 2.
	worker sendMessages: messages.

	self assert: worker smscDatabase collectionForSms size equals: 2.
	self assert: (worker smscDatabase collectionForSms select: [:each | each lock = 0 ]) size equals: 2.