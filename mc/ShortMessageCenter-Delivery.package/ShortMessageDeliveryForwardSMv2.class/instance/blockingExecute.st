as yet unclassified
blockingExecute

	"Copy the list so we can remember what we sent or not"
	pendingMessages := messages copy.
	waitingSemaphore := Semaphore new.

	tcapLink := deliveryCentral tcapLinkByName: connectionName.
	tcapLink ifNil: [
		logger logNotice: 'Can not find TCAP link' with: { 'connectionName' -> connectionName }.
		^self failAllMessages].

	waitingSemaphore := Semaphore new.
	"We first need to find the IMSI and the MSC number and then can start to deliver"
	self sendRoutingInfoForSM.
	waitingSemaphore wait.