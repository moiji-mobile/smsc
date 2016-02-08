tests-polling
testWaitUntil
	| sem res |
	"This is just blocking for a couple of seconds. MongoDB will time out the cursor a lot earlier than that. Add a first message to the capped collection so we can actually sleep."
	smscDatabase addNewShortMessageNotification: 'First message'.
	res := smscDatabase waitUntil: (DateAndTime now + 2 seconds).
	self assert: res equals: ShortMessageTimeout.

	"Here mongodb will return earlier than anything has arrived. Let's accept it for now"
	res := smscDatabase waitUntil: (DateAndTime now + 10 seconds).
	self assert: res equals: ShortMessageWorkArrived.

	"Jump through some hoops?"
	sem := Semaphore new.
	[ (Delay forMilliseconds: 100) wait. smscDatabase addNewShortMessageNotification: 'Wake up'] fork.
	res := smscDatabase waitUntil: (DateAndTime now + 5 seconds).
	self assert: res equals: ShortMessageWorkArrived.

	"And add a message so we do not wait at all"
smscDatabase
		insertShortMessage: 'This is a message' destination: '1234567890' deliverIn:  0 seconds expireIn: 10 days.
	res := smscDatabase waitUntil: (DateAndTime now + 10 seconds).
	self assert: res equals: ShortMessageWorkPending.
