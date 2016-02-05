notification
insertShortMessage: anEncodedMessage destination: aNumber deliverIn: aDuration expireIn: anExpirationDuration

	| record now deliveryTime expirationTime |

	now := DateAndTime now.
	deliveryTime := now + aDuration.
	expirationTime := now + anExpirationDuration.
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