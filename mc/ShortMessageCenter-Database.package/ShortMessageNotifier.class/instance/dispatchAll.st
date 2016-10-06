as yet unclassified
dispatchAll
	| dispatch res |
	"Swap now and dispatch"
	dispatch := self swapNotificationQueue.

	"And finally ingorm it"
	res := lastReturnCount ifNil: [ 0 ].
	dispatch ifNotNil: [
		dispatch do: [:notifier | notifier dispatch: res ]].