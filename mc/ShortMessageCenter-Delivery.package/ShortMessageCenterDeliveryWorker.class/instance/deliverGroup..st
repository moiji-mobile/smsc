as yet unclassified
deliverGroup: aGroup
	[ 
		self doDeliverGroup: aGroup
	] ensure: [
		"Reschedule messages that are left over"
		| messages |
		messages := aGroup messages.
		messages copy do: [:msg |
			"Remove messages?"
			smscDatabase unlockAndReschedule: (msg at: '_id') increaseAttempt: false.
			messages remove: msg]]