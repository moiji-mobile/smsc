as yet unclassified
match: request

	| subclasses |
	subclasses := ShortMessageCenterRestBase allSubclasses.
	subclasses do: [ :each |
		(each match: request)
			ifNotNil: [ :variables |
				^ each new
					variables: variables;
					omDatabase: omDatabase;
					smscDatabase: smscDatabase;
					yourself ] ].
	^ nil  