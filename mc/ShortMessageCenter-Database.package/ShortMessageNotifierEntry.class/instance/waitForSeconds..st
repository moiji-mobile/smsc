as yet unclassified
waitForSeconds: aNumberOfSeconds
	^(sem waitTimeoutSeconds: aNumberOfSeconds)
		ifTrue: [ShortMessageTimeout]
		ifFalse: [
			lastResult > 0
				ifTrue: [ShortMessageWorkArrived]
				ifFalse: [ShortMessageTimeout]].