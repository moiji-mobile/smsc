as yet unclassified
withDatabase: aDatabase
	^self new
		root: aDatabase shortMessageDatabaseRoot;
		database: aDatabase;
		yourself.