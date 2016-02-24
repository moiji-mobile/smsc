forward
signalForwardFailure: aMessage
	"Fail.. and give up the dialogue..."
	| lastMessage |
	lastMessage := pendingMessages removeFirst.
	deliveryDialogue := nil.

	">>#failMessage can trigger a semaphore that adds some concurrency, so
	let us read pendingMessages first"
	pendingMessages isEmpty
		ifTrue: [
			self failMessage: lastMessage]
		ifFalse: [
			self failMessage: lastMessage.
			self sendNextMessage].