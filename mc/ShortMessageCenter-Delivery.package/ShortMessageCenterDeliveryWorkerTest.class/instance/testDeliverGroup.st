tests-as yet unclassified
testDeliverGroup

	| route message group |
	smscDatabase
		insertShortMessage: SMPPMessageTest new exampleDeliverSM messageType: '123' destination: '1234567890' source: '1234' deliverIn: 0 seconds expireIn: 10 days receivedOn: 'link1'.

	"Add routes"
	omDatabase
		createOrUpdateDeliveryRoute: (ShortMessageDeliveryRoute new
												routeName: 'r1';
												destinationAddressPrefix: '12345';
												addMethod: (ShortMessageDeliveryMethodTest new
													beSuccessful;
													yourself);
												yourself).

	route := (omDatabase collectionForDeliveryRoute select: [:each | ]) first.
	message := (smscDatabase collectionForSms select: [:each | ]) first.
	group := ShortMessageDeliveryGroup new
					route: route;
					add: message;
					yourself. 

	ShortMessageCenterDeliveryWorker new
		smscDatabase: smscDatabase;
		deliverGroup: group.

	self assert: smscDatabase collectionForSms size equals: 0.
	self assert: group messages size equals: 0. 