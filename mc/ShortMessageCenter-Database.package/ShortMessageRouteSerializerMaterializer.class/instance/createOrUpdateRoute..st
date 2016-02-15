api
createOrUpdateRoute: aRoute
	collection
		update: { 'routeName' -> aRoute routeName } asDictionary
		with: aRoute toExternalDictionary
		flags: UpdateOperation flagUpsert.