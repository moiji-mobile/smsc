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
			order: {
				'destinationAddressPrefixLength' -> Mongo descending.
				'sourceAddressPrefixLength' -> Mongo descending.
				'systemId' -> Mongo descending.
				'default' -> Mongo ascending} asDictionary
	].
	^result