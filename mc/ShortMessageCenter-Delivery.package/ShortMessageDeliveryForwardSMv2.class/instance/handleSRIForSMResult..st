routing
handleSRIForSMResult: aResult

	aResult result ifNil: [^self signalRoutingInfoFailure: 'no result'].

	imsi := aResult resultObject imsi.
	mscNumber := aResult resultObject locationInfoWithLMSI networkNode_Number fromE164.

	self sendNextMessage.