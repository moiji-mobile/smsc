as yet unclassified
testInserterFunctions
	"Go through the life-cycle..."

	| link |
	self assert: omDatabase allInserterLinks size equals: 0.
	self assert: (omDatabase findInserterLink: 'bla') isNil.

	link := smppMaterializer materialize: {
		'connectionName' -> 'TestConnection'.
		'connectionType' -> 'client'.
		'hostname' -> 'HOST'.
		'port' -> 2324.
		'systemType' -> nil.
		'systemId' -> nil.
		'password' -> nil.
	} asDictionary.
	omDatabase createOrUpdateInserterLink: link.
	self assert: omDatabase allInserterLinks size equals: 1.
	self assert: (omDatabase findInserterLink: 'bla') isNil.


	link := omDatabase findInserterLink: 'TestConnection'.
	link systemId: 'newSystemId'.
	omDatabase createOrUpdateInserterLink: link.

	link := omDatabase findInserterLink: 'TestConnection'.
	self assert: link systemId equals: 'newSystemId'.

	omDatabase removeInserterLink: link.
	self assert: omDatabase allInserterLinks size equals: 0.