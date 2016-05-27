tests-delivery-route
testFindRouteForDestinationSourceSystemId

	pool withDatabase: [:db |
		| route |

		omDatabase := ShortMessageOMDatabase withDatabase: db.

		"Add routes for the test..."
		route := ShortMessageDeliveryRoute new.
		route
			routeName: 'default-route';
			default: true.
		omDatabase createOrUpdateDeliveryRoute: route.

		route
			routeName: 'destination-route';
			default: false;
			destinationAddressPrefix: '49177'.
		omDatabase createOrUpdateDeliveryRoute: route.

		route
			routeName: 'destination-route-long';
			default: false;
			destinationAddressPrefix: '491772'.
		omDatabase createOrUpdateDeliveryRoute: route.

		route
			routeName: 'source-dest-route';
			destinationAddressPrefix: '49177';
			sourceAddressPrefix: '32123'.
		omDatabase createOrUpdateDeliveryRoute: route.

		route
			routeName: 'fulltest';
			systemId: 'systemId'.
		omDatabase createOrUpdateDeliveryRoute: route.

		self assert: omDatabase allDeliveryRoutes size equals: 5.

		"Now the actual tests..."
		route := omDatabase findRouteForDestination: '49178122' source: '4234324324' systemId: 'RandomLink'.
		self assert: (route at: 'routeName') equals: 'default-route'.

		route := omDatabase findRouteForDestination: '491778122' source: 'wrong' systemId: 'wrongToo'.
		self assert: (route at: 'routeName') equals: 'destination-route'.
		route := omDatabase findRouteForDestination: '49177222' source: 'wrong' systemId: 'wrongToo'.
		self assert: (route at: 'routeName') equals: 'destination-route-long'.

		route := omDatabase findRouteForDestination: '491778122' source: '32123' systemId: 'wrongToo'.
		self assert: (route at: 'routeName') equals: 'source-dest-route'.

		route := omDatabase findRouteForDestination: '491778122' source: '32123' systemId: 'systemId'.
		self assert: (route at: 'routeName') equals: 'fulltest'.
	]