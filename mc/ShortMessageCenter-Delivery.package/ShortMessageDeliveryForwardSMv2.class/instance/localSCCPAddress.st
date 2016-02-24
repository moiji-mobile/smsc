sccp
localSCCPAddress
	^ (SCCPAddress createForSSN: ssn)
		routedOnSSN: false;
		gtiFromAddr:  (SCCPGlobalTitleTranslation new
							nature: SCCPGlobalTitle naiInternationalNumber;
							plan: SCCPGlobalTitle npISDN;
							addr: globalTitle;
							translation: 0;
							yourself);
		yourself