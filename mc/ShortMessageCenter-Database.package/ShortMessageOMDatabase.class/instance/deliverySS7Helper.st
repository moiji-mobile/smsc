delivery-ss7
deliverySS7Helper
	^ShortMessageLinkSerializerMaterializer new
		collection: collectionForSS7Delivery;
		materializer: ShortMessageLinkSS7Materializer new;
		yourself.