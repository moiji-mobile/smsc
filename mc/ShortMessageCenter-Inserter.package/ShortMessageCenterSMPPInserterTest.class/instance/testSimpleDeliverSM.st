as yet unclassified
testSimpleDeliverSM
	| message |

	self assert: smscDatabase collectionForSms size equals: 0.
	self assert: smscDatabase collectionForNotification size equals: 0.
	self assert: mockConnection sent size equals: 0.

	message := SMPPMessage readFrom: SMPPMessageTest new exampleDeliverSM readStream.
	smscInserter smppCommand: message from: mockConnection handler.

	self assert: smscDatabase collectionForSms size equals: 1.
	self assert: smscDatabase collectionForNotification size equals: 1.
	self assert: mockConnection sent size equals: 1.