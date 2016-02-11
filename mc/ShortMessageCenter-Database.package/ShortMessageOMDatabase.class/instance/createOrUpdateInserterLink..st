smpp
createOrUpdateInserterLink: aLink
	collectionForInserter
		update: { 'connectionName' -> aLink connectionName } asDictionary
		with: aLink toExternalDictionary
		flags: UpdateOperation flagUpsert.