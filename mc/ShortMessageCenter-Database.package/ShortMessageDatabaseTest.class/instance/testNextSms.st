tests-sms-read
testNextSms
	| next duration |
	smscDatabase
		insertShortMessage: 'message late' destination: '1'  deliverIn: 10 days  expireIn: 20 days;
		insertShortMessage: 'message mid' destination: '2' deliverIn: 5 minutes expireIn: 20 days;
		insertShortMessage: 'message soon' destination: '3' deliverIn: 30 seconds expireIn: 20 days;
		insertShortMessage: 'message late' destination: '4' deliverIn: 4 hours expireIn: 10 days.

	next := smscDatabase nextSms.
	self assert: (next at: 'encodedMessage') equals: 'message soon'.

	duration := ((next at: 'deliveryTime') - DateAndTime now) asDuration.
	self assert: duration seconds > 10.
	self assert: duration seconds < 31.