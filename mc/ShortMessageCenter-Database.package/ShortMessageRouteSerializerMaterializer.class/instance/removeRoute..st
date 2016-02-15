api
removeRoute: aRoute
	collection remove: { 'routeName' -> aRoute routeName } asDictionary.