tests-as yet unclassified
testSmsPending

	self deny: smscDatabase smsPending.
	smscDatabase
		insertShortMessage: 'This is a message' destination: '1234567890' deliverIn:  0 seconds expireIn: 10 days.
	self assert: smscDatabase smsPending.