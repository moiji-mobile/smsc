as yet unclassified
materializeFrom: aDescription
	^self new
		connectionName: (aDescription at: 'connectionName');
		messageType: (aDescription at: 'messageType');
		yourself.