as yet unclassified
storeDeliverSM: aDeliverSM from: aSystemId
	smscDatabase
		insertShortMessage: aDeliverSM toMessage asByteArray
		destination: aDeliverSM destinationAddress
		source: aDeliverSM sourceAddress
		deliverIn: 0 seconds expireIn: 10 days
		receivedOn: aSystemId.