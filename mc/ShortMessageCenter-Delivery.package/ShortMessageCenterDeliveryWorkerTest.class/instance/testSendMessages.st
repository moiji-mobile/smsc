tests-as yet unclassified
testSendMessages
	| messages |
	worker smscDatabase
		insertShortMessage: SMPPMessageTest new exampleDeliverSM messageType: '123' destination: '1234567890' source: '1234' deliverIn: 0 seconds expireIn: 10 days receivedOn: 'link1';
		insertShortMessage: SMPPMessageTest new exampleDeliverSM messageType: '123' destination: '1234567890' source: '1234' deliverIn: 0 seconds expireIn: 10 days receivedOn: 'link1'.

	"Add routes"
	worker omDatabase
		createOrUpdateDeliveryRoute: (ShortMessageDeliveryRoute new
												routeName: 'r1';
												destinationAddressPrefix: '12345';
												addMethod: (ShortMessageDeliveryMethodTest new
													beSuccessful;
													yourself);
												yourself).
 
	messages := worker messagesSelector selectMessages.
	self assert: messages size equals: 2.
	worker sendMessages: messages.

	self assert: worker smscDatabase collectionForSms size equals: 0.