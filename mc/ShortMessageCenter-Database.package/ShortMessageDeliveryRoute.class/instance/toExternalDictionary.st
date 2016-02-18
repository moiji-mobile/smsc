as yet unclassified
toExternalDictionary
	| dict |
	dict := {
		'routeName' -> routeName.
		'systemId' -> systemId.
		'priority' -> priority.
		'default' -> default.
		'methods' -> (methods collect: [:each | each toExternalDictionary]) asArray.
	} asDictionary.

	destinationAddressPrefix ifNotNil: [ 
		dict
			at: 'destinationAddressPrefix' put: destinationAddressPrefix;
			at: 'destinationAddressPrefixLength' put: destinationAddressPrefix size].
	sourceAddressPrefix ifNotNil: [
		dict
			at: 'sourceAddressPrefix' put: sourceAddressPrefix;
			at: 'sourceAddressPrefixLength' put: sourceAddressPrefix size].
	^dict