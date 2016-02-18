notification
insertShortMessage: anEncodedMessage destination: aNumber source: aSourceNumber deliverIn: aDuration expireIn: anExpirationDuration receivedOn: aSystemId

	| record now deliveryTime expirationTime |

	now := DateAndTime now.
	deliveryTime := now + aDuration.
	expirationTime := now + anExpirationDuration.
	logger logDebug: 'Inserting short message' with: { 'dest' -> aNumber. 'deliverIn' -> aDuration. 'expireIn' -> anExpirationDuration }.

	record := {
		'sourceMSISDN' -> aSourceNumber.
		'destMSISDN' -> aNumber.
		'encodedMessage' -> anEncodedMessage.
		'creationTime' -> now.
		'lastAttemptTime' -> nil.
		'deliveryTime' -> deliveryTime.
		'attempts' -> 0.
		'lock' -> 0.
		'expirationTime' -> expirationTime.
		'receivedOn' -> aSystemId.
	} asDictionary.
	collectionForSms add: record.
	self addNewShortMessageNotification: 'New message for ', aNumber.