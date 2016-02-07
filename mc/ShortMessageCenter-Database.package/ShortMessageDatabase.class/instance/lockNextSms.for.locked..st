sms-read
lockNextSms: aDestMSISDN for: aSystemName locked: aList
	| res now |
	now := DateAndTime now.
	res := database command: {
		'findAndModify' -> collectionForSms name.
		'query' -> [:item |
			(item destMSISDN = aDestMSISDN) &
			(item deliveryTime <= now) &
			(item _id notIn: aList) ] asMongoQuery.
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