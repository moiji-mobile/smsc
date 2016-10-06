as yet unclassified
swapNotificationQueue.
	^sem critical: [
		"Don't swap if there is nothing to do."
		notifiers isEmpty
			ifTrue: [ nil ]
			ifFalse: [
				| tmp |
				tmp := notifiers.
				notifiers := OrderedCollection new.
				tmp]].