as yet unclassified
withDatabase: aDatabase
	^self new
		root: aDatabase shortMessageDatabaseRoot;
		database: aDatabase;
		collectionForLock: (MongoCollection database: aDatabase name: 'deliveryLock');
		collectionForNotification: (MongoCollection database: aDatabase name: 'insertNotification');
		collectionForSms: (MongoCollection database: aDatabase name: 'smsQueue');
		yourself.