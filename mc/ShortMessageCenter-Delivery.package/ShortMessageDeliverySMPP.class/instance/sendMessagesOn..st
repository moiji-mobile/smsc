as yet unclassified
sendMessagesOn: aConnection
	"Copy the list so we can remember what we sent or not"
	pendingMessages := messages copy.
	waitingSemaphore := Semaphore new.

	pendingMessages do: [:each |
		self sendMessage: each on: aConnection].

	waitingSemaphore wait.