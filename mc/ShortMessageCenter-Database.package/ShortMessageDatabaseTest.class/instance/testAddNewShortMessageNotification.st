tests-notification
testAddNewShortMessageNotification
	| result |

	self assert: smscDatabase collectionForNotification size equals: 1.
	smscDatabase addNewShortMessageNotification: 'This is a notification'.

	self assert: smscDatabase collectionForNotification size equals: 2.
	result := (smscDatabase collectionForNotification select: {'type' -> 'NewMesssage'} asDictionary) first.
	self assert: (result at: 'message') equals: 'This is a notification'.