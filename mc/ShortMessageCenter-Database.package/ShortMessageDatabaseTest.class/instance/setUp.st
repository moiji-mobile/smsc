as yet unclassified
setUp
	root := Mongo local.
	root open.
	database := MongoDatabase root: root name: 'smscTest'.
	"Remove the database before we start"
	database drop.

	"Create the capped collection"
	ShortMessageDatabase createInsertNotificationCollection: database.
	smscDatabase := ShortMessageDatabase withDatabase: database.
	smscDatabase createLockIndex.