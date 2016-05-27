as yet unclassified
get
	omDatabasePool withDatabase: [:db |
		| omDatabase links |
		omDatabase := ShortMessageOMDatabase withDatabase: db.
		links := omDatabase allDeliverySS7Links.
		links := links collect: [:each | each toExternalDictionary ].
		self jsonResponse: links]