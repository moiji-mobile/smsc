as yet unclassified
testSimpleCreation
	| method external |
	method := ShortMessageDeliveryMethodSMPP new.
	method connectionName: 'aConnectionName'.
	external := method toExternalDictionary.
	self assert: external keys sort equals: #('class' 'connectionName').