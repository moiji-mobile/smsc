api
removeLink: aLink
	collection remove: { 'connectionName' -> aLink connectionName } asDictionary.
	self checkLastError.