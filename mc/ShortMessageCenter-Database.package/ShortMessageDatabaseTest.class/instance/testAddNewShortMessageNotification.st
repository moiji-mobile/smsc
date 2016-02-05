tests-notification
testAddNewShortMessageNotification
	| result |

	self assert: smscDatabase collectionForNotification size equals: 0.
	smscDatabase addNewShortMessageNotification: 'This is a notification'.

	self assert: smscDatabase collectionForNotification size equals: 1.
	result := (smscDatabase collectionForNotification select: Dictionary new) first.
	self assert: (result at: 'message') equals: 'This is a notification'.