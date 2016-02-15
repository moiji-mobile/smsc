as yet unclassified
testMaterialization
	| method |
	method := ShortMessageDeliveryMethodBase materializeFrom: {
		'class' -> 'ShortMessageDeliveryMethodSMPP'.
		'connectionName' -> 'aConnectionName'.
	} asDictionary.
	self assert: method class equals: ShortMessageDeliveryMethodSMPP.
	self assert: method connectionName equals: 'aConnectionName'.