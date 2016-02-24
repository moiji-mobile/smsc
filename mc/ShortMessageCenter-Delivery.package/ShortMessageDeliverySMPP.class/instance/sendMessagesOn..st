as yet unclassified
sendMessagesOn: aConnection
	pendingMessages do: [:each |
		self sendMessage: each on: aConnection].