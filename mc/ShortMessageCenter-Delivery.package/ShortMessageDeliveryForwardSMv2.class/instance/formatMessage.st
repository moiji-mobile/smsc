forward
formatMessage
	|  deliverSM tpdu |
	deliverSM := converter converMessageToDeliverSM: pendingMessages first.
	tpdu := deliverSM toDeliverTPDUDictionary.
	^ShortMessageTPDUHelper encodeDeliver: tpdu.