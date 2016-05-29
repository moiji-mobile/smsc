tests-as yet unclassified
testDeliverGroupFailingDeliveryExpired

	| route message group originalDeliveryTime newDeliveryTime |
	worker smscDatabase
		insertShortMessage: SMPPMessageTest new exampleDeliverSM messageType: '123' destination: '1234567890' source: '1234' deliverIn: 0 seconds expireIn: -10 days receivedOn: 'link1'.

	"Add routes"
	worker omDatabase
		createOrUpdateDeliveryRoute: (ShortMessageDeliveryRoute new
												routeName: 'r1';
												destinationAddressPrefix: '12345';
												addMethod: (ShortMessageDeliveryMethodTest new
													beFailure;
													yourself);
												yourself).

	route := (worker omDatabase collectionForDeliveryRoute select: [:each | ]) first.
	message := (worker smscDatabase collectionForSms select: [:each | ]) first.
	originalDeliveryTime := message at: 'deliveryTime'.
	worker smscDatabase collectionForSms
			update: { '_id' -> (message at: '_id') } asDictionary
			with: { '$set' -> { 'lock' -> 1 } asDictionary } asDictionary.
	group := ShortMessageDeliveryGroup new
					route: route;
					add: message;
					yourself. 

	worker deliverGroup: group.

	self assert: worker smscDatabase collectionForSms size equals: 0.
	self assert: group messages size equals: 0.