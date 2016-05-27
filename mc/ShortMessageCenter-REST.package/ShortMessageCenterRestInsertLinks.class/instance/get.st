as yet unclassified
get
	omDatabasePool withDatabase: [:db |
		| omDatabase links |
		omDatabase := ShortMessageOMDatabase withDatabase: db.

		links := omDatabase allInserterLinks.
		links := links collect: [:each | each toExternalDictionary ].
		self jsonResponse: links]