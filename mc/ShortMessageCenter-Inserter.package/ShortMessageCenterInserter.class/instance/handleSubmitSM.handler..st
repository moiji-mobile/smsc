as yet unclassified
handleSubmitSM: aMessage handler: aHandler
	logger logDebug: 'handleSubmitSM' with: { 'systemId' -> aHandler systemId }.

	self storeSM: aMessage from: aHandler systemId.
	self smppReturnSuccessOn: aHandler for: aMessage