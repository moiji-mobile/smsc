as yet unclassified
storeDeliverSM: aDeliverSM 
	smscDatabase
		insertShortMessage: aDeliverSM toMessage asByteArray
		destination: aDeliverSM destinationAddress
		deliverIn: 0 seconds expireIn: 10 days.