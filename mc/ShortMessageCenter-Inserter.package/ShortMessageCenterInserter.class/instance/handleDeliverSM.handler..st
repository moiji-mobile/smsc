as yet unclassified
handleDeliverSM: aMessage handler: aHandler
	logger logDebug: 'handleDeliverSM' with: { 'systemId' -> aHandler systemId }.

	self storeSM: aMessage from: aHandler systemId.
	self smppReturnSuccessOn: aHandler for: aMessage