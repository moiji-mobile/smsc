as yet unclassified
setUp
	| root database |
	root := Mongo local.
	root open.
	database := MongoDatabase root: root name: 'smscTest'.
	"Remove the database before we start"
	database drop.
	omDatabase := ShortMessageOMDatabase withDatabase: database.
	smppMaterializer := ShortMessageLinkSMPPMaterializer new.
	ss7Materializer := ShortMessageLinkSS7Materializer new.