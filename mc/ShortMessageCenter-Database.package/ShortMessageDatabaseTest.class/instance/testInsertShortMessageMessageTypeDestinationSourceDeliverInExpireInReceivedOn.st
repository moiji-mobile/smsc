tests-notification
testInsertShortMessageMessageTypeDestinationSourceDeliverInExpireInReceivedOn
"Check this is empty"
	| result |

	self deny: smscDatabase smsPending.
	self assert: smscDatabase collectionForSms size equals: 0.

	"Insert a message"
	smscDatabase
		insertShortMessage: 'This is a message' messageType: 1 destination: '1234567890' source: 'foo' deliverIn:  10 hours expireIn: 10 days receivedOn: 'testLink'.

	"Check that there is one"
	self assert: smscDatabase collectionForSms size equals: 1.
	result := (smscDatabase collectionForSms select: Dictionary new) first.
	self assert: result keys sort equals: #('_id' 'attempts' 'creationTime' 'deliveryTime' 'destMSISDN' 'encodedMessage' 'encodedMessageType' 'expirationTime' 'lastAttemptTime' 'lock' 'receivedOn' 'sourceMSISDN').
	self deny: smscDatabase smsPending description: '10 hours can not have passed yet'.