api
createOrUpdateLink: aLink
	collection
		update: { 'connectionName' -> aLink connectionName } asDictionary
		with: aLink toExternalDictionary
		flags: UpdateOperation flagUpsert.