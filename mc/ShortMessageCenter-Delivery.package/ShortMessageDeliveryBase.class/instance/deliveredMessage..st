result
deliveredMessage: aMessage
	logger logNotice: 'Delivered SMS' with: { 'smsId' -> (aMessage at: '_id') }.
	messages remove: aMessage.
	smscDatabase removeSms: (aMessage at: '_id').