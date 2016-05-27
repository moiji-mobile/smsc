as yet unclassified
match: request

	| subclasses |
	subclasses := ShortMessageCenterRestBase allSubclasses.
	subclasses do: [ :each |
		(each match: request)
			ifNotNil: [ :variables |
				^ each new
					variables: variables;
					omDatabasePool: omDatabasePool;
					smscDatabasePool: smscDatabasePool;
					yourself ] ].
	^ nil  