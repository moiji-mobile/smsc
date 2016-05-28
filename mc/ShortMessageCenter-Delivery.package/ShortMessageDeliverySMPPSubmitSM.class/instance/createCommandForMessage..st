as yet unclassified
createCommandForMessage: aMessage
	| submitSM command |
	self flag: #todo. "Avoid load + re-encode"
	submitSM := converter converMessageToSubmitSM: aMessage.
	command := SMPPBinaryCommand
					initWith: submitSM toMessage asByteArray
					messageType: SMPPSubmitSM messageType.
	^command
	