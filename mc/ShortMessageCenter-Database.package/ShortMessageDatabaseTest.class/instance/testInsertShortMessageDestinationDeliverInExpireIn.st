tests-notification
testInsertShortMessageDestinationDeliverInExpireIn
"Check this is empty"
	| result |
	self assert: smscDatabase collectionForSms size equals: 0.

	"Insert a message"
	smscDatabase
		insertShortMessage: 'This is a message' destination: '1234567890' deliverIn:  10 hours expireIn: 1 day.

	"Check that there is one"
	self assert: smscDatabase collectionForSms size equals: 1.
	result := (smscDatabase collectionForSms select: Dictionary new) first.
	self assert: result keys sort equals: #('_id' 'attempts' 'creationTime' 'deliveryTime' 'destMSISDN' 'encodedMessage' 'expirationTime' 'lastAttemptTime' 'lock').