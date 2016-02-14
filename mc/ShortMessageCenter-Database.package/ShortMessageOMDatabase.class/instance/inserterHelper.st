inserter
inserterHelper
	^ShortMessageLinkSerializerMaterializer new
		collection: collectionForInserter;
		materializer: ShortMessageLinkSMPPMaterializer new;
		yourself