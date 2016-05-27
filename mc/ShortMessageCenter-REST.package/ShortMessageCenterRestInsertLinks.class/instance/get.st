as yet unclassified
get
	omDatabasePool withSmscOmDatabase: [:omDatabase |
		| links |
		links := omDatabase allInserterLinks.
		links := links collect: [:each | each toExternalDictionary ].
		self jsonResponse: links]