sms-read
findAndLockPendingSms: aSystemName
	| res now |
	now := DateAndTime now.
	res := database command: {
		'findAndModify' -> collectionForSms name.
		'query' -> [:item | (item lock = 0) & (item deliveryTime <= now) ] asMongoQuery.
		'update' -> {
			'$set' -> {
				'lockTime' -> now.
				'lockedBy' -> aSystemName.
				'lock' -> 1.
			} asDictionary.
		} asDictionary.
		'new' -> true.
	} asDictionary.
	^res ifNotNil: [res at: 'value'].