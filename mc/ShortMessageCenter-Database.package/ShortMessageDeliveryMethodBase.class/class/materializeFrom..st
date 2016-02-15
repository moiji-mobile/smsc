as yet unclassified
materializeFrom: aDescription 
	| className |
	className := aDescription at: 'class'.
	self allSubclassesDo: [:each |
		each name asString = className ifTrue: [
			^each materializeFrom: aDescription]].

	^self error: 'Can not materialize'