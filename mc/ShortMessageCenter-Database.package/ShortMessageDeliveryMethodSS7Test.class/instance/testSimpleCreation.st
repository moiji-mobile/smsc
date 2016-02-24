as yet unclassified
testSimpleCreation
	| method external |
	method := ShortMessageDeliveryMethodSS7 new.
	method connectionName: 'aConnectionName'.
	method globalTitle: 'aGlobalTitle'.
	method ssn: 7.
	method smscNumber: 'aSmscNumber'.
	method sendRoutingInfoTranslationType: 0.
	method forwardSMTranslationType: 0.
	method mapVersion: 2.

	external := method toExternalDictionary.
	self assert: external keys sort equals: #('class' 'connectionName' 'forwardSMTranslationType' 'globalTitle' 'mapVersion' 'sendRoutingInfoTranslationType' 'smscNumber' 'ssn').