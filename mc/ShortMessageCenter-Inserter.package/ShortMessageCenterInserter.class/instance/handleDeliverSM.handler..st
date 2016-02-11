as yet unclassified
handleDeliverSM: aMessage handler: aHandler
	logger logDebug: 'handleDeliverSM' with: { 'systemId' -> aHandler systemId }.

	self storeDeliverSM: aMessage body from: aHandler systemId.
	self smppReturnSuccessOn: aHandler for: aMessage