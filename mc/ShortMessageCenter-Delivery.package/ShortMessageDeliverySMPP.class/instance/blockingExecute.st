as yet unclassified
blockingExecute
	| smppLink smppConnection |

	"Copy the list so we can remember what we sent or not"
	pendingMessages := messages copy.
	waitingSemaphore := Semaphore new.

	smppLink := deliveryCentral smppLinkByName: connectionName.
	smppLink ifNil: [
		logger logNotice: 'Can not find smpp link' with: { 'connectionName' -> connectionName }.
		^self failAllMessages].

	smppConnection := smppLink anyAuthenticatedConnection.
	smppConnection ifNil: [
		logger logNotice: 'Can not find smpp connection' with: { 'connectionName' -> connectionName }.
		^self failAllMessages].

	self sendMessagesOn: smppConnection.
	waitingSemaphore wait.