as yet unclassified
removeSms: aMessageId 
	collectionForSms remove: { '_id' -> aMessageId } asDictionary.
	self checkLastError.