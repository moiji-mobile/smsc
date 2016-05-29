as yet unclassified
selectGroupMessages: messages
	| groups |
	groups := SmallDictionary new.

	messages copy do: [:each |
		| route destMSISDN sourceMSISDN systemId |
		destMSISDN := each at: 'destMSISDN'.
		sourceMSISDN := each at: 'sourceMSISDN'.
		systemId := each at: 'receivedOn'.
		route := omDatabase findRouteForDestination: destMSISDN source: sourceMSISDN systemId: systemId.
		route ifNotNil: [
			| routeName |
			routeName := route at: 'routeName'.
			logger logNotice: 'Selected route for' with: {
				'routeName' -> routeName.
				'destMSISDN'-> destMSISDN.
				'sourceMSISDN' -> sourceMSISDN.
				'systemId' -> systemId }.

			"Put it into the delivery group"
			(groups at: routeName ifAbsentPut: [ShortMessageDeliveryGroup initWithRoute: route]) add: each.
			"We take ownership of this event now"
			messages remove: each]].
	^groups