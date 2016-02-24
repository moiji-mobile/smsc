routing
handleSRIForSMResult: aResult

	imsi := aResult resultObject imsi.
	mscNumber := aResult resultObject locationInfoWithLMSI networkNode_Number fromE164.

	self sendNextMessage.