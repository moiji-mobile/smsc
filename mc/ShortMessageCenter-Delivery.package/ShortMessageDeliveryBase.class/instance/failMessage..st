result
failMessage: aMessage
	logger logNotice: 'Failed to deliver message. Requeuing' with: { 'smsId' -> (aMessage at: '_id') }.
	smscDatabase incrementDeliveryAttempt: (aMessage at: '_id')