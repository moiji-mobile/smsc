as yet unclassified
sendMessages: messages
	| destMSISDN |
	destMSISDN := messages first at: 'destMSISDN'.
	undeliveredMessages := messages copy.

	[
		| deliveryGroups |
		deliveryGroups := self selectGroupMessages: messages.
	] ensure: [
		logger logNotice: 'Releasing destination lock' with: { 'worker' -> workerName. 'dest' -> destMSISDN }.
		undeliveredMessages do: [:each |
			smscDatabase unlockSms: (each at: '_id') for: workerName].
		smscDatabase releaseDestination: destMSISDN.
	]