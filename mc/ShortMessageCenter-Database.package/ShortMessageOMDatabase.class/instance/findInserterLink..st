smpp
findInserterLink: aName
	| result |
	result := collectionForInserter queryOne: [:query |
					query where: [:item | item connectionName = aName ] ].
	^result ifNotNil: [self materializeSMPPLink: result]