smpp
allInserterLinks
	| result links |

	links := OrderedCollection new.
	result := collectionForInserter query: [:query | ].
	result do: [:each |
		| link |
		link := self materializeSMPPLink: each.
		link isNil
			ifTrue: [logger logError: 'Can not materialize' with: {'connectionName' -> each}]
			ifFalse: [links add: link]].
	^links