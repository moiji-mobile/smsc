as yet unclassified
toExternalDictionary
	| dict |
	dict := {
		'routeName' -> routeName.
		'systemId' -> systemId.
		'priority' -> priority.
		'default' -> default.
		'destinationAddressPrefix' -> destinationAddressPrefix.
		'destinationAddressPrefixLength' -> destinationAddressPrefix size.
		'methods' -> (methods collect: [:each | each toExternalDictionary]) asArray.
	} asDictionary.

	sourceAddressPrefix ifNotNil: [
		dict
			at: 'sourceAddressPrefix' put: sourceAddressPrefix;
			at: 'sourceAddressPrefixLength' put: sourceAddressPrefix size].
	^dict