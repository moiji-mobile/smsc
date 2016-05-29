as yet unclassified
rescheduleOrRemove: msg
	| expireTime |
	expireTime := DateAndTime now.
	(msg at: 'expirationTime') < expireTime
		ifTrue: [
			logger logNotice: 'Expiring message' with: {'worker' -> workerName. 'id' -> (msg at: '_id')}.
			smscDatabase removeSms: (msg at: '_id')]
		ifFalse: [
			logger logNotice: 'Re-scheduling message' with: {'worker' -> workerName. 'id' -> (msg at: '_id')}.
			smscDatabase unlockAndReschedule: (msg at: '_id') increaseAttempt: false].