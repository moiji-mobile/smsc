forward
signalForwardSuccess
	| lastMessage |
	"One ROS invocation succeeded. Move forward by taking the"
	lastMessage := pendingMessages removeFirst.

	pendingMessages isEmpty
		ifTrue: [
			deliveryDialogue terminate.
			deliveryDialogue := nil.
			self deliveredMessage: lastMessage]
		ifFalse: [
			self deliveredMessage: lastMessage.
			self sendNextMessage].
	