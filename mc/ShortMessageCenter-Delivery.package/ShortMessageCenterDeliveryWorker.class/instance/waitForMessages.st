as yet unclassified
waitForMessages
	| nextSms |
	nextSms := smscDatabase nextSms.
	smscDatabase waitUntil: (nextSms at: 'deliveryTime').