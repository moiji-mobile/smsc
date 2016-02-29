as yet unclassified
sendMessagesOn: aConnection
	pendingMessages copy do: [:each |
		self sendMessage: each on: aConnection].