as yet unclassified
messageType: aString
	(#('deliverSM' 'submitSM') includes: aString) ifFalse: [
		^self error: 'Only deliverSM or submitSM as type allowed'].

	messageType := aString