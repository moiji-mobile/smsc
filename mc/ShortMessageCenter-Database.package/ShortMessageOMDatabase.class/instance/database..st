as yet unclassified
database: aMongoDatabase 
	database := aMongoDatabase.
	self
		collectionForInserter: (MongoCollection database: database name: 'inserterSMPPLinks');
		collectionForDelivery: (MongoCollection database: database name: 'deliverySMPPLinks');
		collectionForSS7Delivery: (MongoCollection database: database name: 'deliverySS7Links');
		collectionForDeliveryRoute: (MongoCollection database: database name: 'deliveryRoute').