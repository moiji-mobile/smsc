delivery
deliveryHelper
	^ShortMessageLinkSerializerMaterializer new
		database: database;
		collection: collectionForDelivery;
		materializer: ShortMessageLinkSMPPMaterializer new;
		yourself