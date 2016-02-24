as yet unclassified
testCreation
	| method delivery |
	method := ShortMessageDeliveryMethodBase materializeFrom: {
		'class' -> 'ShortMessageDeliveryMethodSS7'.
		'connectionName' -> 'aConnectionName'.
		'globalTitle' -> 'aGlobalTitle'.
		'ssn' -> 7.
		'smscNumber' -> 'aSmscNumber'.
		'sendRoutingInfoTranslationType' -> 23.
		'forwardSMTranslationType' -> 21.
		'mapVersion' -> 3.
	} asDictionary.

	delivery := method createDelivery.
	self assert: delivery class equals: ShortMessageDeliveryForwardSMv3.