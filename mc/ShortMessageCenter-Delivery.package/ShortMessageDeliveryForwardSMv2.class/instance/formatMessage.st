forward
formatMessage
	| data deliverSM tpdu |
	data := pendingMessages first at: 'encodedMessage'.
	deliverSM := SMPPDeliverSM new readFrom: data readStream.
	tpdu := deliverSM toDeliverTPDUDictionary.
	^ShortMessageTPDUHelper encodeDeliver: tpdu.