as yet unclassified
testDeliveryRouteFunctions
	"Go through the life-cycle..."

	| route |
	self assert: omDatabase allDeliveryRoutes size equals: 0.
	self assert: (omDatabase findDeliveryRoute: 'bla') isNil.

	route := routeMaterializer materialize: {
		'routeName' -> 'TestConnection'.
		'destinationAddressPrefix' -> 'aDestinationPrefix'.
		'methods' -> {
			{
				'class' -> 'ShortMessageDeliveryMethodSMPP'.
				'connectionName' -> 'aConnectionName'.
			} asDictionary.
		}
	} asDictionary.
	omDatabase createOrUpdateDeliveryRoute: route.
	self assert: omDatabase allDeliveryRoutes size equals: 1.
	self assert: (omDatabase findDeliveryRoute: 'bla') isNil.


	route := omDatabase findDeliveryRoute: 'TestConnection'.
	route systemId: 'newSystemId'.
	omDatabase createOrUpdateDeliveryRoute: route.

	route := omDatabase findDeliveryRoute: 'TestConnection'.
	self assert: route systemId equals: 'newSystemId'.

	omDatabase removeDeliveryRoute: route.
	self assert: omDatabase allDeliveryRoutes size equals: 0.