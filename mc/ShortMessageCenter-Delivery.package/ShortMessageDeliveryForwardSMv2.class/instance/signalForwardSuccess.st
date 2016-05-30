forward
signalForwardSuccess
	| lastMessage |
	"One ROS invocation succeeded. Move forward by taking the"
	lastMessage := pendingMessages first.

	pendingMessages size = 1
		ifTrue: [
			| oldDialogue |
			oldDialogue := deliveryDialogue.
			deliveryDialogue := nil.
			self deliveredMessage: lastMessage.
			"Give up on the dialogue.. even if no TC-end was received"
			oldDialogue smscDiscardAllAndTerminate]
		ifFalse: [
			self deliveredMessage: lastMessage.
			self sendNextMessage].
	