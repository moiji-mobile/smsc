as yet unclassified
testToExternalDictionary
	| route external |

	route := ShortMessageDeliveryRoute new.
	route systemId: 'aSystemId'.
	route sourceAddressPrefix: 'aSourcePrefix'.
	route destinationAddressPrefix: 'aDestinationPrefix'.
	route priority: 100.
	route default: false.
	route addMethod: (ShortMessageDeliveryMethodSS7 new
		connectionName: 'ss7Connection1';
		smscNumber: '12345';
		globalTitle: '12345';
		mapVersion: 2;
		yourself).
	external := route toExternalDictionary.
	self assert: external keys sort equals: #('default' 'destinationAddressPrefix' 'destinationAddressPrefixLength' 'methods' 'priority' 'sourceAddressPrefix' 'sourceAddressPrefixLength' 'systemId').