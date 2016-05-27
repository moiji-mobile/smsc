as yet unclassified
storeSM: aSM from: aSystemId
	smscDatabasePool withSmscDatabase: [:smscDatabase |
		smscDatabase
			insertShortMessage: aSM body toMessage asByteArray
			messageType: aSM body class name asString
			destination: aSM body destinationAddress
			source: aSM body sourceAddress
			deliverIn: 0 seconds expireIn: 10 days
			receivedOn: aSystemId].