*ShortMessageCenter-Delivery
createDelivery
	^((mapVersion = 3)
		ifTrue: [ShortMessageDeliveryForwardSMv3 new]
		ifFalse: [ShortMessageDeliveryForwardSMv2 new])
			connectionName: connectionName;
			globalTitle: globalTitle;
			ssn: ssn;
			smscNumber: smscNumber;
			sendRoutingInfoTranslationType: sendRoutingInfoTranslationType;
			forwardSMTranslationType: forwardSMTranslationType;
			yourself