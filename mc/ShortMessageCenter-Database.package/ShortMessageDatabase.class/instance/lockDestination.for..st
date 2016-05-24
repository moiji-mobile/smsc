sms-read
lockDestination: aDestination for: aSystemName
	| res now |
	now := DateAndTime now.
	[
		^(database command: {
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
			'writeConcern' -> self writeConcern.
		} asDictionary) at: 'value'.
	] on: MongoCommandError do: [:err |
		"Access the reply and check for E11000 to see if it failed?"
		^nil
	].