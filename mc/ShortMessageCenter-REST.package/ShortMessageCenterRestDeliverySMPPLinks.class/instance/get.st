as yet unclassified
get
	omDatabasePool withSmscOmDatabase: [:omDatabase |
		|  links |
		links := omDatabase allDeliveryLinks.
		links := links collect: [:each | each toExternalDictionary ].
		self jsonResponse: links]