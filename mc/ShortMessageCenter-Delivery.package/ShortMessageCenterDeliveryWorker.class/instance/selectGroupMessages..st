as yet unclassified
selectGroupMessages: messages
	| groups |
	groups := SmallDictionary new.

	messages do: [:each |
		| route destMSISDN sourceMSISDN systemId routeName |
		destMSISDN := each at: 'destMSISDN'.
		sourceMSISDN := each at: 'sourceMSISDN'.
		systemId := each at: 'receivedOn'.
		route := omDatabase findRouteForDestination: destMSISDN source: sourceMSISDN systemId: systemId.
		routeName := route at: 'routeName'.
		logger logNotice: 'Selected route for' with: {
			'routeName' -> routeName.
			'destMSISDN'-> destMSISDN.
			'sourceMSISDN' -> sourceMSISDN.
			'systemId' -> systemId }.

		(groups at: routeName ifAbsentPut: [ShortMessageDeliveryGroup initWithRoute: route]) add: each].

	^groups