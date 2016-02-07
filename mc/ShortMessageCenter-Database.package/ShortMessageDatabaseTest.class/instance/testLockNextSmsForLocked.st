tests-sms-read
testLockNextSmsForLocked

	| res ids messages count |
	ids := OrderedCollection new.
	messages := OrderedCollection new.

	smscDatabase
		insertShortMessage: 'message 1' destination: '1234567890' deliverIn:  0 seconds expireIn: 10 days;
		insertShortMessage: 'message 2' destination: '1234567890' deliverIn:  0 seconds expireIn: 10 days;
		insertShortMessage: 'message 3' destination: '1234567890' deliverIn:  0 seconds expireIn: 10 days;
		insertShortMessage: 'message 4' destination: '1234567890' deliverIn:  0 seconds expireIn: 10 days;
		insertShortMessage: 'message 5' destination: '1234567890' deliverIn:  0 seconds expireIn: 10 days.

	self assert: smscDatabase smsPending.
	res := smscDatabase findAndLockPendingSms: 'TestSystem' reject: #().
	ids add: (res at: '_id').
	messages add: (res at: 'encodedMessage').

	"Check we can lock the second message... and then see it is stolen"
	res := smscDatabase findAndLockPendingSms: 'TestFooo' reject: #().
	self deny: (res at: '_id') = (ids first).
	count := smscDatabase collectionForSms sizeForQuery: [:item | item lockedBy = 'TestFooo' ] asMongoQuery.
	self assert: count equals: 1.

	smscDatabase
		insertShortMessage: 'no message' destination: '666666' deliverIn:  0 seconds expireIn: 10 days.

	self assert: smscDatabase smsPending.
	res := smscDatabase lockNextSms: (res at: 'destMSISDN') for: 'TestSystem' locked: ids.
	ids add: (res at: '_id').
	messages add: (res at: 'encodedMessage').
	self assert: smscDatabase smsPending.
	res := smscDatabase lockNextSms: (res at: 'destMSISDN') for: 'TestSystem' locked: ids.
	ids add: (res at: '_id').
	messages add: (res at: 'encodedMessage').
	self assert: smscDatabase smsPending.
	res := smscDatabase lockNextSms: (res at: 'destMSISDN') for: 'TestSystem' locked: ids.
	ids add: (res at: '_id').
	messages add: (res at: 'encodedMessage').
	self assert: smscDatabase smsPending.
	res := smscDatabase lockNextSms: (res at: 'destMSISDN') for: 'TestSystem' locked: ids.
	ids add: (res at: '_id').
	messages add: (res at: 'encodedMessage').

	"Check if we have locked everything we inserted"
	res := smscDatabase lockNextSms: (res at: 'destMSISDN') for: 'TestSystem' locked: ids.
	self assert: res isNil.
	self assert: messages asSet equals: #('message 1' 'message 2' 'message 3' 'message 4' 'message 5') asSet.

	"Check no one has locked it differently"
	count := smscDatabase collectionForSms sizeForQuery: [:item | item lockedBy = 'TestFooo' ] asMongoQuery.
	self assert: count equals: 0.

	self assert: smscDatabase smsPending.
	res := smscDatabase findAndLockPendingSms: 'TestSystem' reject: ids.
	self deny: res isNil.
	self deny: smscDatabase smsPending.