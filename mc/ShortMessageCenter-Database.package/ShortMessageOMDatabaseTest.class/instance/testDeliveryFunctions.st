as yet unclassified
testDeliveryFunctions
	"Go through the life-cycle..."

	| link |
	self assert: omDatabase allDeliveryLinks size equals: 0.
	self assert: (omDatabase findDeliveryLink: 'bla') isNil.

	link := smppMaterializer materialize: {
		'connectionName' -> 'TestConnection'.
		'connectionType' -> 'server'.
		'systemType' -> nil.
		'systemId' -> nil.
		'password' -> nil.
		'port' -> 2345.
		'allowedRemoteAddress' -> nil.
		'allowedRemotePort' -> nil.
		'role' -> #mc.
	} asDictionary.
	omDatabase createOrUpdateDeliveryLink: link.
	self assert: omDatabase allDeliveryLinks size equals: 1.
	self assert: (omDatabase findDeliveryLink: 'bla') isNil.
	self assert: link role equals: #mc.


	link := omDatabase findDeliveryLink: 'TestConnection'.
	link systemId: 'newSystemId'.
	omDatabase createOrUpdateDeliveryLink: link.

	link := omDatabase findDeliveryLink: 'TestConnection'.
	self assert: link systemId equals: 'newSystemId'.

	omDatabase removeDeliveryLink: link.
	self assert: omDatabase allDeliveryLinks size equals: 0.