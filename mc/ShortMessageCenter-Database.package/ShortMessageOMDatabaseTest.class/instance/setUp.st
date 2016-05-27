as yet unclassified
setUp
	pool := VOMongoSessionPool host: 'localhost' port: 27017  database: 'smscTest' username: nil password: nil.
	pool
		size: 1;
		repopulate.

	"Remove the database before we start".
	pool withDatabase: [:db | db drop].

	smppMaterializer := ShortMessageLinkSMPPMaterializer new.
	ss7Materializer := ShortMessageLinkSS7Materializer new.
	routeMaterializer := ShortMessageRouteMaterializer new.