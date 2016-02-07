as yet unclassified
createLockIndex
	| res |
	res := database command: {
		'createIndexes' -> collectionForLock name.
		'indexes' -> {
			{
				'key' -> { 'destMSISDN' -> 1 } asDictionary.
				'name' -> 'one_entry_per_destMSISDN'.
				'unique' -> true.
			} asDictionary.
		}.
	} asDictionary.