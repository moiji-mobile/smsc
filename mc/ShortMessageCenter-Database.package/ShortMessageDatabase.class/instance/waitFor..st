polling
waitFor: aDurationAsSeconds
	| tail |
	tail := notifier register.
	self smsPending ifTrue: [
		tail cancel.
		^ShortMessageWorkPending].
	^tail waitForSeconds: aDurationAsSeconds.