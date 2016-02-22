delivery-route
findRouteForDestination: aDestAddress source: aSourceAddress systemId: aSystemId
	| sourceRegexp destRegexp result |
	sourceRegexp := aSourceAddress asShortMessageCenterPrefixRegexp.
	destRegexp := aDestAddress asShortMessageCenterPrefixRegexp.

	result := collectionForDeliveryRoute queryOne: [:query |
		"We try to get a nice match or optional match"
		query
			where:[:route |
			(
				(route destinationAddressPrefix = {'$regex' -> destRegexp} asDictionary) &
				((route sourceAddressPrefix = {'$regex' -> sourceRegexp} asDictionary) | (route sourceAddressPrefix = nil)) &
				((route systemId = aSystemId) | (route systemId = nil))
			) | (route default = true)] asMongoQuery;
			order: (SmallDictionary new
						at: 'destinationAddressPrefixLength' put: Mongo descending;
						at: 'sourceAddressPrefixLength' put: Mongo descending;
						at: 'systemId' put: Mongo descending;
						at: 'default' put: Mongo ascending;
						yourself).
	].
	^result