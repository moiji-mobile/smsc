forward
signalForwardFailure: aLogMessage
	"Fail.. and give up the dialogue..."
	| lastMessage |

	logger logError: 'SignalForwardFailure' with: { 'imsi' -> imsi. 'msg' -> aLogMessage }.

	deliveryDialogue smscDiscardAllAndTerminate.
	deliveryDialogue := nil.

	lastMessage := pendingMessages first.

	">>#failMessage can trigger a semaphore that adds some concurrency, so
	let us read pendingMessages first"
	pendingMessages size = 1
		ifTrue: [
			self failMessage: lastMessage]
		ifFalse: [
			self failMessage: lastMessage.
			self sendNextMessage].