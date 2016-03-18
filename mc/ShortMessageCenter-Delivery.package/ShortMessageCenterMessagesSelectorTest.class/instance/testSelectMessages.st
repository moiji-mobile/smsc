tests-as yet unclassified
testSelectMessages
	| messages locks |
	smscDatabase
		insertShortMessage: 'This is a message1' messageType: '123' destination: '1234567890' source: '1234' deliverIn: 0 seconds expireIn: 10 days receivedOn: 'link1';
		insertShortMessage: 'This is a message2' messageType: '123' destination: '1234567890' source: '1235' deliverIn: 0 seconds expireIn: 10 days receivedOn: 'link2';
		insertShortMessage: 'This is a message3' messageType: '123' destination: '1234567890' source: '1236' deliverIn: 0 seconds expireIn: 10 days receivedOn: 'link3';
		insertShortMessage: 'This is a message4' messageType: '123' destination: '1234567890' source: '1234' deliverIn: 0 seconds expireIn: 10 days receivedOn: 'link1';
		insertShortMessage: 'This is a message5' messageType: '123' destination: '1234567890' source: '1234' deliverIn: 0 seconds expireIn: 10 days receivedOn: 'link1';
		insertShortMessage: 'This is a message6' messageType: '123' destination: '1234567890' source: '1234' deliverIn: 0 seconds expireIn: 10 days receivedOn: 'link1';
		insertShortMessage: 'This is a message7' messageType: '123' destination: '1234567890' source: '1234' deliverIn: 0 seconds expireIn: 10 days receivedOn: 'link1';
		insertShortMessage: 'This is a message8' messageType: '123' destination: '1234567890' source: '1234' deliverIn: 0 seconds expireIn: 10 days receivedOn: 'link1';
		insertShortMessage: 'This is a message9' messageType: '123' destination: '1234567890' source: '1234' deliverIn: 0 seconds expireIn: 10 days receivedOn: 'link1'.

	self assert: smscDatabase collectionForLock size equals: 0.

	messages := ShortMessageCenterMessagesSelector new
						smscDatabase: smscDatabase;
						workerName: 'worker1';
						selectMessages.

	"Check that upto six messages are now selected and locked"
	self assert: smscDatabase collectionForLock size equals: 1.
	self assert: messages size equals: 6.
	self assert: messages class equals: OrderedCollection.

	"The target is still locked.. so try to see what happens if we lock it again"
	messages := ShortMessageCenterMessagesSelector new
						smscDatabase: smscDatabase;
						workerName: 'worker2';
						selectMessages.
	self assert: smscDatabase collectionForLock size equals: 1.
	self assert: messages isNil.

	locks := smscDatabase collectionForLock select: [:each | ].
	self assert: locks size equals: 1.

	messages := smscDatabase collectionForSms select: [:each | each lock = 0 ].
	self assert: messages size equals: 3.
	messages := smscDatabase collectionForSms select: [:each | each lock = 1 ].
	self assert: messages size equals: 6.

	"See that we can now lock and steal the other SMS"
	smscDatabase releaseDestination: '1234567890'.
	self assert: smscDatabase collectionForLock size equals: 0.
	messages := ShortMessageCenterMessagesSelector new
						smscDatabase: smscDatabase;
						workerName: 'worker2';
						selectMessages.
	self assert: messages size equals: 6.
