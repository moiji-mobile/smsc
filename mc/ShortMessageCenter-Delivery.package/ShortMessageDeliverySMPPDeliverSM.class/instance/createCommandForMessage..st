as yet unclassified
createCommandForMessage: aMessage
	| deliverSM command |
	deliverSM := converter converMessageToDeliverSM: aMessage.
	command := SMPPBinaryCommand
					initWith: deliverSM toMessage asByteArray
					messageType: SMPPDeliverSM messageType.
	^command
	