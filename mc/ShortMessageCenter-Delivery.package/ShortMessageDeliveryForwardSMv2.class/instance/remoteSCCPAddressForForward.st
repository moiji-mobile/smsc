sccp
remoteSCCPAddressForForward
	^(SCCPAddress createForSSN: #msc)
			routedOnSSN: false;
			gtiFromAddr:  (SCCPGlobalTitleTranslation new
								nature: SCCPGlobalTitle naiInternationalNumber;
								plan: SCCPGlobalTitle npISDN;
								addr: mscNumber;
								translation: forwardSMTranslationType;
								yourself);
			yourself