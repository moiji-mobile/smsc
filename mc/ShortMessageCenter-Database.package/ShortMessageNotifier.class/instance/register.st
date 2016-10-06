as yet unclassified
register
	| notifier |
	notifier := ShortMessageNotifierEntry new.
	sem critical: [
		self flag: #todo. "E.g. we could wake up the polling thread to be more effective"
		notifiers add: notifier].
	^notifier