as yet unclassified
withDatabase: aDatabase
	^self new
		root: aDatabase shortMessageDatabaseRoot;
		database: aDatabase;
		collectionForInserter: (MongoCollection database: aDatabase name: 'inserterSMPPLinks');
		collectionForDelivery: (MongoCollection database: aDatabase name: 'deliverySMPPLinks');
		collectionForSS7Delivery: (MongoCollection database: aDatabase name: 'deliverySS7Links');
		yourself.