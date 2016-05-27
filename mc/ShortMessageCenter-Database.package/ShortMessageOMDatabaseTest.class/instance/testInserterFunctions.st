as yet unclassified
testInserterFunctions
	"Go through the life-cycle..."

	pool withDatabase: [:db |
		| link |
		omDatabase := ShortMessageOMDatabase withDatabase: db.
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
			'role' -> #esme.
		} asDictionary.
		omDatabase createOrUpdateInserterLink: link.
		self assert: omDatabase allInserterLinks size equals: 1.
		self assert: (omDatabase findInserterLink: 'bla') isNil.
		self assert: link role equals: #esme.


		link := omDatabase findInserterLink: 'TestConnection'.
		link systemId: 'newSystemId'.
		omDatabase createOrUpdateInserterLink: link.

		link := omDatabase findInserterLink: 'TestConnection'.
		self assert: link systemId equals: 'newSystemId'.

		omDatabase removeInserterLink: link.
		self assert: omDatabase allInserterLinks size equals: 0.
	]