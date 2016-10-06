as yet unclassified
doQueryOnce
	| query tailableCursor |
	query := MongoQuery new
		database: database;
		collection: collectionForNotification;
		doBlock: [:each | ];
		yourself.
	tailableCursor := MongoTailableCursor new
		query: query;
		root: database shortMessageDatabaseRoot;
		yourself.
	tailableCursor create.

	"Will return within 2-3 seconds"
	tailableCursor requestNext.
	lastReturnCount := tailableCursor readNext returnCount.
