inserter
inserterHelper
	^ShortMessageLinkSerializerMaterializer new
		database: database;
		collection: collectionForInserter;
		materializer: ShortMessageLinkSMPPMaterializer new;
		yourself