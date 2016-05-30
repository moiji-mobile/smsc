as yet unclassified
setUp
	testEndPoint := TCAPTestServiceEndPoint new
		asn1Model: ShortMessageCenterDeliveryCentral asn1Model.
	smscEndPoint := TCAPTestServiceEndPoint new
		asn1Model: ShortMessageCenterDeliveryCentral asn1Model.
	smscEndPoint addHandler: (TCAPDialogueTimeoutHandler new timeout: 10 minutes; yourself).

	testEndPoint connectTo: smscEndPoint.
	smscEndPoint connectTo: testEndPoint.