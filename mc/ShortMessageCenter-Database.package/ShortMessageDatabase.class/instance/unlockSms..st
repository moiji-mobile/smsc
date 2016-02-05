sms-read
unlockSms: aSmsOID
	| res now |
	now := DateAndTime now.
	res := database command: {
		'findAndModify' -> collectionForSms name.
		'query' -> [:item | item _id = aSmsOID ] asMongoQuery.
		'update' -> {
			'$set' -> {
				'lockTime' -> nil.
				'lockedBy' -> nil.
				'lock' -> 0.
			} asDictionary.
		} asDictionary.
		'new' -> true.
	} asDictionary.
	^res ifNotNil: [res at: 'value'].