sms-read
unlockSms: aSmsOID for: aSystem
	| res now |
	now := DateAndTime now.
	res := database command: {
		'findAndModify' -> collectionForSms name.
		'query' -> [:item | (item _id = aSmsOID) & (item lockedBy = aSystem)] asMongoQuery.
		'update' -> {
			'$set' -> {
				'lockTime' -> nil.
				'lockedBy' -> nil.
				'lock' -> 0.
			} asDictionary.
		} asDictionary.
		'new' -> true.
		'writeConcern' -> self writeConcern.
	} asDictionary.
	^res ifNotNil: [res at: 'value'].