delivery-ss7
deliverySS7Helper
	^ShortMessageLinkSerializerMaterializer new
		database: database;
		collection: collectionForSS7Delivery;
		materializer: ShortMessageLinkSS7Materializer new;
		yourself.