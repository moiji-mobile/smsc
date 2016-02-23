as yet unclassified
blockingExecute
	messages copy do: [:each |
		testMode = #succesful ifTrue: [
			self deliveredMessage: each].
		testMode = #failure ifTrue: [
			self failMessage: each].
		testMode = #unreachable ifTrue: [
			self unreachableMessage: each]].