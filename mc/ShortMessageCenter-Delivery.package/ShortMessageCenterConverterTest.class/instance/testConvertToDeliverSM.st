as yet unclassified
testConvertToDeliverSM
	| submitSM deliverSM |
	submitSM := (SMPPMessage readFrom: SMPPMessageTest new exampleSubmitSM readStream) body.
	deliverSM := converter convertToDeliverSM: submitSM.
	self assert: deliverSM class equals: SMPPDeliverSM.
	self assert: deliverSM toMessage asByteArray equals: #[0 1 1 57 50 50 53 48 48 49 0 1 1 52 48 48 57 57 57 49 54 0 2 0 0 0 0 0 49 68 105 101 115 32 105 115 116 32 101 105 110 101 32 84 101 115 116 110 97 99 104 114 105 99 104 116 33 32 32 50 48 49 52 45 48 51 45 48 49 95 49 54 46 52 48 46 52 50].