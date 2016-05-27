as yet unclassified
get
	omDatabasePool withSmscOmDatabase: [:omDatabase |
		| links |
		links := omDatabase allDeliverySS7Links.
		links := links collect: [:each | each toExternalDictionary ].
		self jsonResponse: links]