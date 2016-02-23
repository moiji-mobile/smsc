as yet unclassified
incrementDeliveryAttempt: aMessageId 
	collectionForSms
		update: { '_id' -> aMessageId } asDictionary
		with: {
			'$inc' -> { 'attempts' -> 1} asDictionary.
			'$set' -> { 'lastAttemptTime' -> DateAndTime now } asDictionary
		} asDictionary