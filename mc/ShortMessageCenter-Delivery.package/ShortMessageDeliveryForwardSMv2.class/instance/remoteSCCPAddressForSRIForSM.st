sccp
remoteSCCPAddressForSRIForSM
	| destMSISDN |
	destMSISDN := pendingMessages first at: 'destMSISDN'.
	^(SCCPAddress createForSSN: #hlr)
			routedOnSSN: false;
			gtiFromAddr:  (SCCPGlobalTitleTranslation new
								nature: SCCPGlobalTitle naiInternationalNumber;
								plan: SCCPGlobalTitle npISDN;
								addr: destMSISDN;
								translation: sendRoutingInfoTranslationType;
								yourself);
			yourself