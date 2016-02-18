tests-sms-read
testNextSms
	| next duration |
	smscDatabase
		insertShortMessage: 'message late' destination: '1' source: 'foo'  deliverIn: 10 days  expireIn: 20 days receivedOn: 'testLink';
		insertShortMessage: 'message mid' destination: '2' source: 'foo' deliverIn: 5 minutes expireIn: 20 days receivedOn: 'testLink';
		insertShortMessage: 'message soon' destination: '3' source: 'foo' deliverIn: 30 seconds expireIn: 20 days receivedOn: 'testLink';
		insertShortMessage: 'message late' destination: '4' source: 'foo' deliverIn: 4 hours expireIn: 10 days receivedOn: 'testLink'.

	next := smscDatabase nextSms.
	self assert: (next at: 'encodedMessage') equals: 'message soon'.

	duration := ((next at: 'deliveryTime') - DateAndTime now) asDuration.
	self assert: duration seconds > 10.
	self assert: duration seconds < 31.