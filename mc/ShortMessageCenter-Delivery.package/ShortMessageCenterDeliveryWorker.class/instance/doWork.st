as yet unclassified
doWork
	[
		ModuleBoundary runSynchronous: [
			| res |
			res := self handleMessages.
			res ifTrue: [^self]]
	] repeat.