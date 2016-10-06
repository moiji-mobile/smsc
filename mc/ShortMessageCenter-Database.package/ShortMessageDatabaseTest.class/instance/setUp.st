as yet unclassified
setUp
	| notRoot notDatabase notColl |
	root := Mongo local.
	root open.
	database := MongoDatabase root: root name: 'smscTest'.
	"Remove the database before we start"
	database drop.

	"Create the capped collection"
	ShortMessageDatabase createInsertNotificationCollection: database.
	smscDatabase := ShortMessageDatabase withDatabase: database.
	smscDatabase createLockIndex.

	notRoot := Mongo local.
	notRoot open.
	notDatabase := MongoDatabase root: notRoot name: 'smscTest'.
	notColl := MongoCollection database: notDatabase name: (smscDatabase collectionForNotification name).
	notifier := ShortMessageNotifier new
						database: notDatabase collectionForNotification: notColl;
						yourself.
	smscDatabase notifier: notifier.
	notifier run.