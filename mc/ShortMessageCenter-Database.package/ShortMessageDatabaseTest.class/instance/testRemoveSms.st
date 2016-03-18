tests-as yet unclassified
testRemoveSms

	| message |
	self assert: smscDatabase collectionForSms size equals: 0.

	"Insert a message"
	smscDatabase
		insertShortMessage: 'MsgOne' messageType: '123' destination: '1234567890' source: 'foo' deliverIn:  10 hours expireIn: 10 days receivedOn: 'testLink';
		insertShortMessage: 'MsgTwo' messageType: '123' destination: '1234567890' source: 'foo' deliverIn:  10 hours expireIn: 10 days receivedOn: 'testLink';
		insertShortMessage: 'MsgThree' messageType: '123' destination: '1234567890' source: 'foo' deliverIn:  10 hours expireIn: 10 days receivedOn: 'testLink'.
	self assert: smscDatabase collectionForSms size equals: 3.

	message := smscDatabase collectionForSms queryOne: [:query |
						query where: [:each| each encodedMessage = 'MsgTwo' ]].
	smscDatabase removeSms: (message at: '_id').
	self assert: smscDatabase collectionForSms size equals: 2.

	message := smscDatabase collectionForSms queryOne: [:query |
						query where: [:each| each encodedMessage = 'MsgOne' ]].
	smscDatabase removeSms: (message at: '_id').
	self assert: smscDatabase collectionForSms size equals: 1.

	message := smscDatabase collectionForSms queryOne: [:query |
						query where: [:each| each encodedMessage = 'MsgThree' ]].
	smscDatabase removeSms: (message at: '_id').
	self assert: smscDatabase collectionForSms size equals: 0.