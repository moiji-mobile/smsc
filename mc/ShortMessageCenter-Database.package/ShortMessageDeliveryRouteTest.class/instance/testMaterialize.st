as yet unclassified
testMaterialize
	| route |
	route := ShortMessageDeliveryRoute materializeFrom: {
		'routeName' -> 'aRouteName'.
		'destinationAddressPrefix' -> 'aDestinationPrefix'.
		'methods' -> {
			{
				'class' -> 'ShortMessageDeliveryMethodSMPP'.
				'connectionName' -> 'aConnectionName'.
			} asDictionary.
		}
	} asDictionary.

	self assert: route routeName equals: 'aRouteName'.
	self assert: route systemId equals: nil.
	self assert: route priority equals: nil.
	self assert: route default equals: nil.
	self assert: route sourceAddressPrefix equals: nil.
	self assert: route destinationAddressPrefix equals: 'aDestinationPrefix'.
	self assert: route methods size equals: 1.
	self assert: route methods first class equals: ShortMessageDeliveryMethodSMPP.
	self assert: route methods first connectionName equals: 'aConnectionName'.

	"Once more with the optional ones being set"
	route := ShortMessageDeliveryRoute materializeFrom: {
		'routeName' -> 'aRouteName'.
		'systemId' -> 'aSystemId'.
		'priority' -> 99.
		'default' -> false.
		'sourceAddressPrefix' -> 'aSourceAddressPrefix'.
		'destinationAddressPrefix' -> 'aDestinationPrefix'.
		'methods' -> {
			{
				'class' -> 'ShortMessageDeliveryMethodSMPP'.
				'connectionName' -> 'aConnectionName'.
			} asDictionary.
		}
	} asDictionary.

	self assert: route systemId equals: 'aSystemId'.
	self assert: route priority equals: 99.
	self assert: route default equals: false.
	self assert: route sourceAddressPrefix equals: 'aSourceAddressPrefix'.
	self assert: route destinationAddressPrefix equals: 'aDestinationPrefix'.
	self assert: route methods size equals: 1.
	self assert: route methods first class equals: ShortMessageDeliveryMethodSMPP.
	self assert: route methods first connectionName equals: 'aConnectionName'.