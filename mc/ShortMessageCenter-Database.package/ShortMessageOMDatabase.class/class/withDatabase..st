as yet unclassified
withDatabase: aDatabase
	^self new
		root: aDatabase shortMessageDatabaseRoot;
		database: aDatabase;
		collectionForInserter: (MongoCollection database: aDatabase name: 'smppLinks');
		yourself.