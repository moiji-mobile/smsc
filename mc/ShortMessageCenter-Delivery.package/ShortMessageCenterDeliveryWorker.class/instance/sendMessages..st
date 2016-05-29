as yet unclassified
sendMessages: messages
	| destMSISDN |
	destMSISDN := messages first at: 'destMSISDN'.

	[
		| deliveryGroups |
		deliveryGroups := self selectGroupMessages: messages.
		deliveryGroups associationsDo: [:assoc |
			self deliverGroup: assoc value].
	] ensure: [
		logger logNotice: 'Releasing destination lock' with: { 'worker' -> workerName. 'dest' -> destMSISDN. 'messagesSize' -> messages size}.
		messages do: [:each |
			smscDatabase unlockAndReschedule: (each at: '_id') increaseAttempt: false].
		smscDatabase releaseDestination: destMSISDN.
	]