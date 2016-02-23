as yet unclassified
unlockAndReschedule: aMessageID increaseAttempt: doIncrease
	| updates now |
	logger logNotice: 'Re-scheduling delivery time' with: { 'smsId' -> aMessageID }.

	now := DateAndTime now.
	updates := {
		'$set' -> {
			'lockTime' -> nil.
			'lockedBy' -> nil.
			'lock' -> 0.
			'deliveryTime' -> (now + 30 minutes).
		} asDictionary.
	} asDictionary.
	
	doIncrease ifTrue: [
		(updates at: '$set')
			at: 'lastAttemptTime' put: now.
		updates at: '$inc' put: { 'attempts' -> 1} asDictionary].

	collectionForSms
		update: { '_id' -> aMessageID } asDictionary
		with: updates.