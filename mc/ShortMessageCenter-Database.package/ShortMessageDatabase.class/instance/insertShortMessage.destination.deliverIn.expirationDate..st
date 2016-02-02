notification
insertShortMessage: anEncodedMessage destination: aNumber deliverIn: aDuration expirationDate: expirationTime

	| record now deliveryTime |

	now := DateAndTime now.
	deliveryTime := now + aDuration.
	record := {
		'destMSISDN' -> aNumber.
		'encodedMessage' -> anEncodedMessage.
		'creationTime' -> now.
		'lastAttemptTime' -> nil.
		'deliveryTime' -> deliveryTime.
		'attempts' -> 0.
		'lock' -> 0.
		'expirationTime' -> expirationTime
	} asDictionary.
	collectionForSms add: record.
	self addNewShortMessageNotification: 'New message for ', aNumber.