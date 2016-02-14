as yet unclassified
testDeliverySS7Functions
	"Go through the life-cycle..."

	| link |
	self assert: omDatabase allDeliverySS7Links size equals: 0.
	self assert: (omDatabase findDeliverySS7Link: 'bla') isNil.

	link := ss7Materializer materialize: {
		'connectionName' -> 'TestConnection'.
		'hostname' -> 'host'.
		'port' -> 5000.
		'token' -> nil.
	} asDictionary.
	omDatabase createOrUpdateDeliverySS7Link: link.
	self assert: omDatabase allDeliverySS7Links size equals: 1.
	self assert: (omDatabase findDeliverySS7Link: 'bla') isNil.


	link := omDatabase findDeliverySS7Link: 'TestConnection'.
	link token: 'newToken'.
	omDatabase createOrUpdateDeliverySS7Link: link.

	link := omDatabase findDeliverySS7Link: 'TestConnection'.
	omDatabase removeDeliveryLink: link.
	self assert: omDatabase allDeliveryLinks size equals: 0.