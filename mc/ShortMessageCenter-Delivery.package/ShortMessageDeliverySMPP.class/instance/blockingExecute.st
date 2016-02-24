as yet unclassified
blockingExecute
	| smppLink smppConnection |
	smppLink := deliveryCentral smppLinkByName: connectionName.
	smppLink ifNil: [
		logger logNotice: 'Can not find smpp link' with: { 'connectionName' -> connectionName }.
		^self failAllMessages].

	smppConnection := smppLink anyAuthenticatedConnection.
	smppConnection ifNil: [
		logger logNotice: 'Can not find smpp connection' with: { 'connectionName' -> connectionName }.
		^self failAllMessages].

	self sendMessagesOn: smppConnection.
