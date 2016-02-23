as yet unclassified
materializeFrom: aDescription
	^self new
		testMode: (aDescription at: 'testMode');
		yourself.