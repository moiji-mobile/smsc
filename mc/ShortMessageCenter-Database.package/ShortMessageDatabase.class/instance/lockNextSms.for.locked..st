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
		'sort' -> [:item |
			item creationTime = Mongo ascending ] asMongoQuery.
		'update' -> {
			'$set' -> {
				'lockTime' -> now.
				'lockedBy' -> aSystemName.
				'lock' -> 1.
			} asDictionary.
		} asDictionary.
		'new' -> true.
	} asDictionary.
	logger logDebug: 'Locking next' with: { 'res nil' -> res isNil. 'systemName' -> aSystemName. 'destMSISDN' -> aDestMSISDN }.
	^res ifNotNil: [res at: 'value'].