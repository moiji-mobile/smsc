as yet unclassified
materializeFrom: aCollection 
	^self new
		routeName: (aCollection at: 'routeName');
		systemId: (aCollection at: 'systemId' ifAbsent: [nil]);
		priority: (aCollection at: 'priority' ifAbsent: [nil]);
		default: (aCollection at: 'default' ifAbsent: [nil]);
		destinationAddressPrefix: (aCollection at: 'destinationAddressPrefix' ifAbsent: [nil]);
		sourceAddressPrefix: (aCollection at: 'sourceAddressPrefix' ifAbsent: [nil]);
		methods: ((aCollection at: 'methods' ifAbsent: [#()])
						collect: [:each | ShortMessageDeliveryMethodBase materializeFrom: each]) asArray;
		yourself.