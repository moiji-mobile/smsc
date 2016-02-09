as yet unclassified
convertToDeliverSM: submitSm 
	^SMPPDeliverSM new
		serviceType: submitSm serviceType;
		sourceTypeOfNumber: submitSm sourceTypeOfNumber;
		sourceNumberingPlanIndicator: submitSm sourceNumberingPlanIndicator;
		sourceAddress: submitSm sourceAddress;
		destinationTypeOfNumber: submitSm destinationTypeOfNumber;
		destinationNumberingPlanIndicator: submitSm destinationNumberingPlanIndicator;
		destinationAddress: submitSm destinationAddress;
		esmClass: submitSm esmClass;
		protocolId: submitSm protocolId;
		priorityLevel: submitSm priorityLevel;
		scheduleDeliveryTime: nil; "Must be nil for DeliverSM"
		validityPeriod: nil; "Must be nil for DeliverSM"
		registeredDelivery: submitSm registeredDelivery;
		replaceIfPresent: submitSm replaceIfPresent;
		dataCoding: submitSm dataCoding;
		smDefaultMessageId: nil;
		shortMessage: submitSm shortMessage;
		userMessageReference: submitSm userMessageReference;
		sourcePort: submitSm sourcePort;
		"source_addr_subunit not in deliverSM"
		destinationPort: submitSm destinationPort;
		"dest_addr_subunit not in deliverSM"
		sarMessageReferenceNumber: submitSm sarMessageReferenceNumber;
		sarTotalSegments: submitSm sarTotalSegments;
		sarSegmentNumber: submitSm sarSegmentNumber;
		"more_message_to_send not present"
		userResponseCode: submitSm userResponseCode;
		privacyIndicator: submitSm privacyIndicator;
		payloadType: submitSm payloadType;
		messagePayload: submitSm messagePayload;
		"callback_num multiple times.. can not be handled by the current code"
		"callback_num_pres_ind not in deliverSM"
		"callback_num_atag not in deliverSM"
		sourceSubAddress: submitSm sourceSubAddress;
		destinationSubAddress: submitSm destinationSubAddress;
		"display_time not in deliverSM"
		"sms_signal not in deliverSM"
		"ms_validity not in deliverSM"
		"ms_msg_wait_facilities not in deliverSM"
		"number_of_messages not in deliverSM"
		"alert_on_msg_delivery not in deliverSM"
		languageIndicator: submitSm languageIndicator;
		"its_reply_type not in deliverSM"
		itsSessionInfo: submitSm itsSessionInfo;
		"ussd_service_op not in deliverSM"
		networkErrorCode: nil;
		messageState: nil;
		yourself.