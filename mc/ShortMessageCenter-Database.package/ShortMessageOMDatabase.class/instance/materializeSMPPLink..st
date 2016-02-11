smpp
materializeSMPPLink: aDescription
	^(SMPPConnection materializeFrom: aDescription)
		ifNil: [SMPPConnectionManager materializeFrom: aDescription]