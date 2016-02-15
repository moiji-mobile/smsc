as yet unclassified
testMaterialization
	| method |
	method := ShortMessageDeliveryMethodBase materializeFrom: {
		'class' -> 'ShortMessageDeliveryMethodSS7'.
		'connectionName' -> 'aConnectionName'.
		'globalTitle' -> 'aGlobalTitle'.
		'smscNumber' -> 'aSmscNumber'.
		'sendRoutingInfoTranslationType' -> 23.
		'forwardSMTranslationType' -> 21.
		'mapVersion' -> 2.
	} asDictionary.

	self assert: method class equals: ShortMessageDeliveryMethodSS7.
	self assert: method connectionName equals: 'aConnectionName'.
	self assert: method globalTitle equals: 'aGlobalTitle'.
	self assert: method smscNumber equals: 'aSmscNumber'.
	self assert: method sendRoutingInfoTranslationType equals: 23.
	self assert: method forwardSMTranslationType equals: 21.
	self assert: method mapVersion equals: 2.
	