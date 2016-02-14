as yet unclassified
materialize: aDescription
	^(SMPPConnection materializeFrom: aDescription)
		ifNil: [SMPPConnectionManager materializeFrom: aDescription]
