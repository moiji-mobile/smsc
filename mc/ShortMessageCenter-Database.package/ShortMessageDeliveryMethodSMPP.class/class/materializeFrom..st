as yet unclassified
materializeFrom: aDescription
	^self new
		connectionName: (aDescription at: 'connectionName');
		yourself.