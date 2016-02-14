api
allLinks	
	| result links |

	links := OrderedCollection new.
	result := collection query: [:query | ].
	result do: [:each |
		| link |
		link := materializer materialize: each.
		link isNil
			ifTrue: [logger logError: 'Can not materialize' with: {'connectionName' -> each}]
			ifFalse: [links add: link]].
	^links