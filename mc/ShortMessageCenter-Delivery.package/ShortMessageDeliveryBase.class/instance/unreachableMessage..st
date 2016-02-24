result
unreachableMessage: aMessage
	| id |

	id := aMessage at: '_id'.
	logger logNotice: 'User not reachable' with: { 'smsId' -> id. 'destMSISDN' -> (aMessage at: 'destMSISDN') }.
	smscDatabase unlockAndReschedule: (aMessage at: '_id')  increaseAttempt: true.
	messages remove: aMessage.