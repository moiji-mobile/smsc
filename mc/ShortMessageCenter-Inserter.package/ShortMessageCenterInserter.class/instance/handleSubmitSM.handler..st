as yet unclassified
handleSubmitSM: aMessage handler: aHandler
	|  deliverSM |
	logger logDebug: 'handleSubmitSM' with: { 'systemId' -> aHandler systemId }.

	deliverSM := self convertToDeliverSM: aMessage body.
	self storeDeliverSM: deliverSM from: aHandler systemId.
	self smppReturnSuccessOn: aHandler for: aMessage