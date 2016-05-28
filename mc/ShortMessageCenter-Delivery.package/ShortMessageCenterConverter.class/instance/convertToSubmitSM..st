as yet unclassified
convertToSubmitSM: deliverSm 
	^SMPPSubmitSM new
		serviceType: deliverSm serviceType;
		sourceTypeOfNumber: deliverSm sourceTypeOfNumber;
		sourceNumberingPlanIndicator: deliverSm sourceNumberingPlanIndicator;
		sourceAddress: deliverSm sourceAddress;
		destinationTypeOfNumber: deliverSm destinationTypeOfNumber;
		destinationNumberingPlanIndicator: deliverSm destinationNumberingPlanIndicator;
		destinationAddress: deliverSm destinationAddress;
		esmClass: deliverSm esmClass;
		protocolId: deliverSm protocolId;
		priorityLevel: deliverSm priorityLevel;
		scheduleDeliveryTime: nil; "NULL in DeliverSM"
		validityPeriod: nil; "NULL in DeliverSM"
		registeredDelivery: deliverSm registeredDelivery;
		replaceIfPresent: deliverSm replaceIfPresent;
		dataCoding: deliverSm dataCoding;
		smDefaultMessageId: nil; "It is not a canned message"
		shortMessage: deliverSm shortMessage;
		userMessageReference: deliverSm userMessageReference;
		sourcePort: deliverSm sourcePort;
		"source_addr_subunit not in deliverSM"
		destinationPort: deliverSm destinationPort;
		"dest_addr_subunit not in deliverSM"
		sarMessageReferenceNumber: deliverSm sarMessageReferenceNumber;
		sarTotalSegments: deliverSm sarTotalSegments;
		sarSegmentNumber: deliverSm sarSegmentNumber;
		"more_message_to_send not present"
		privacyIndicator: deliverSm privacyIndicator;
		payloadType: deliverSm payloadType;
		messagePayload: deliverSm messagePayload;
		"callback_num multiple times.. can not be handled by the current code"
		"callback_num_pres_ind not in deliverSM"
		"callback_num_atag not in deliverSM"
		sourceSubAddress: deliverSm sourceSubAddress;
		destinationSubAddress: deliverSm destinationSubAddress;
		userResponseCode: deliverSm userResponseCode;
		"display_time not in deliverSM"
		"sms_signal not in deliverSM"
		"ms_validity not in deliverSM"
		"ms_msg_wait_facilities not in deliverSM"
		"number_of_messages not in deliverSM"
		"alert_on_msg_delivery not in deliverSM"
		languageIndicator: deliverSm languageIndicator;
		"its_reply_type not in deliverSM"
		itsSessionInfo: deliverSm itsSessionInfo;
		yourself.