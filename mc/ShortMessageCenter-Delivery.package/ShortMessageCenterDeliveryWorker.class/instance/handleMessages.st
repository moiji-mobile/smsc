as yet unclassified
handleMessages
	"Re-open the database just in case something has happened."
	root isOpen ifTrue: [root close].
	root open.

	[
		| messages |
		messages := messagesSelector selectMessages.
		messages isNil
			ifTrue: [self waitForMessages]
			ifFalse: [self sendMessages: messages].
	] repeat.
