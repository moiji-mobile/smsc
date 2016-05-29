tests-as yet unclassified
testSelectGroupMessagesUnroutable
	"Add messages"
	| messages groups |
	smscDatabase
		insertShortMessage: 'This is a message1' messageType: '123' destination: '1234567890' source: '1234' deliverIn: 0 seconds expireIn: 10 days receivedOn: 'link1';
		insertShortMessage: 'This is a message2' messageType: '123' destination: '1234567890' source: '1235' deliverIn: 0 seconds expireIn: 10 days receivedOn: 'link2';
		insertShortMessage: 'This is a message3' messageType: '123' destination: '1234567890' source: '1236' deliverIn: 0 seconds expireIn: 10 days receivedOn: 'link3';
		insertShortMessage: 'This is a message4' messageType: '123' destination: '1234567890' source: '1234' deliverIn: 0 seconds expireIn: 10 days receivedOn: 'link1';
		insertShortMessage: 'This is a message5' messageType: '123' destination: '1234567890' source: '1234' deliverIn: 0 seconds expireIn: 10 days receivedOn: 'link1'.

	"No routes"

		messages := smscDatabase collectionForSms select: [:each |].
		groups := ShortMessageCenterDeliveryWorker new
							omDatabase: omDatabase;
							selectGroupMessages: messages.
		self assert: messages size equals: 5.
		self assert: groups size equals: 0.