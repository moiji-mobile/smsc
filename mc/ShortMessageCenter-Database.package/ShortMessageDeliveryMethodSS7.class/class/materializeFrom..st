as yet unclassified
materializeFrom: aDescription
	^self new
		connectionName: (aDescription at: 'connectionName');
		globalTitle: (aDescription at: 'globalTitle');
		smscNumber: (aDescription at: 'smscNumber');
		sendRoutingInfoTranslationType: (aDescription at: 'sendRoutingInfoTranslationType');
		forwardSMTranslationType: (aDescription at: 'forwardSMTranslationType');
		mapVersion: (aDescription at: 'mapVersion');
		yourself