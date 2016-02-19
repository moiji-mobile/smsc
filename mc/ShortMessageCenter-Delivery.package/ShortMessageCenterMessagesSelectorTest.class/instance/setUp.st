as yet unclassified
setUp
	| root database |
	root := Mongo local.
	root open.
	database := MongoDatabase root: root name: 'smscTest'.
	"Remove the database before we start"
	database drop.
	smscDatabase := ShortMessageDatabase withDatabase: database.
	smscDatabase createLockIndex.