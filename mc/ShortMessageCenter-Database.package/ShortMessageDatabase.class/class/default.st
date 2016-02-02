as yet unclassified
default
	| root database |
	root := Mongo local.
	root open.
	database := MongoDatabase root: root name: 'smsc'.
	^self new
		root: root;
		database: database;
		collectionForLock: (MongoCollection database: database name: 'deliveryLock');
		collectionForNotification: (MongoCollection database: database name: 'insertNotification');
		collectionForSms: (MongoCollection database: database name: 'smsQueue');
		yourself.