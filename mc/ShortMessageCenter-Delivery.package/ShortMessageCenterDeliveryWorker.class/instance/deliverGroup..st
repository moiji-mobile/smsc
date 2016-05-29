as yet unclassified
deliverGroup: aGroup
	[ 
		self doDeliverGroup: aGroup
	] ensure: [
		"Reschedule messages that are left over"
		| messages |
		messages := aGroup messages.
		messages copy do: [:msg |
			self rescheduleOrRemove: msg.
			messages remove: msg]]