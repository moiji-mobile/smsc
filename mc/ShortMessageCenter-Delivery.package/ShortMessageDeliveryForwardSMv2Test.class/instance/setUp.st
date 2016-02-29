as yet unclassified
setUp
	testEndPoint := TCAPTestServiceEndPoint new
		asn1Model: ShortMessageCenterDeliveryCentral asn1Model.
	smscEndPoint := TCAPTestServiceEndPoint new
		asn1Model: ShortMessageCenterDeliveryCentral asn1Model.

	testEndPoint connectTo: smscEndPoint.
	smscEndPoint connectTo: testEndPoint.