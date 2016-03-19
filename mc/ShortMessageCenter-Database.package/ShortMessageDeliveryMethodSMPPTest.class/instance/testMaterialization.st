as yet unclassified
testMaterialization
	| method |
	method := ShortMessageDeliveryMethodBase materializeFrom: {
		'class' -> 'ShortMessageDeliveryMethodSMPP'.
		'connectionName' -> 'aConnectionName'.
		'messageType' -> 'deliverSM'.
	} asDictionary.
	self assert: method class equals: ShortMessageDeliveryMethodSMPP.
	self assert: method connectionName equals: 'aConnectionName'.
	self assert: method messageType equals: 'deliverSM'.

	method := ShortMessageDeliveryMethodBase materializeFrom: {
		'class' -> 'ShortMessageDeliveryMethodSMPP'.
		'connectionName' -> 'aConnectionName'.
		'messageType' -> 'submitSM'.
	} asDictionary.
	self assert: method class equals: ShortMessageDeliveryMethodSMPP.
	self assert: method connectionName equals: 'aConnectionName'.
	self assert: method messageType equals: 'submitSM'.