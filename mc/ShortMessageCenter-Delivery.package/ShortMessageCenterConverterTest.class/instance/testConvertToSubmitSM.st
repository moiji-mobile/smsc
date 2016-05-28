as yet unclassified
testConvertToSubmitSM
	| submitSM deliverSM |
	deliverSM := (SMPPMessage readFrom: SMPPMessageTest new exampleDeliverSM readStream) body.
	submitSM := converter convertToSubmitSM: deliverSM.
	self assert: submitSM class equals: SMPPSubmitSM.
	self assert: submitSM toMessage asByteArray equals: #[0 1 1 56 56 56 56 49 55 48 50 52 55 56 50 50 55 54 0 1 1 56 56 56 56 49 55 48 50 52 55 56 50 50 55 54 0 3 0 0 4 0 0 10 116 101 115 116 32 49 50 58 48 51].