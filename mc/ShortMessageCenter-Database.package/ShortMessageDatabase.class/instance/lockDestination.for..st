sms-read
lockDestination: aDestination for: aSystemName
	| res now |
	now := DateAndTime now.
	res := database command: {
		'findAndModify' -> collectionForLock name.
		'query' -> [:item | (item destMSISDN = aDestination) & (item lock = 0) ] asMongoQuery.
		'update' -> {
			'$set' -> {
				'lockTime' -> now.
				'lockedBy' -> aSystemName.
				'lock' -> 1.
			} asDictionary.
		} asDictionary.
		'new' -> true.
		'upsert' -> true.
	} asDictionary.

	"nil in case something went wrong? and if already present an index will prevent the second entry"
	^res isNil
		ifTrue: [nil]
		ifFalse: [res at: 'value' ifAbsent: [nil]].
