as yet unclassified
waitForMessages
	| nextSms wakeUpTime |
	nextSms := smscDatabase nextSms.
	wakeUpTime := nextSms isNil
							ifTrue: [DateAndTime now + sleepTime]
							ifFalse: [nextSms at: 'deliveryTime'].
	smscDatabase waitUntil: wakeUpTime.