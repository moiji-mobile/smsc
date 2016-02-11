as yet unclassified
get
	| links |
	links := omDatabase allInserterLinks.
	links := links collect: [:each | each toExternalDictionary ].
	self jsonResponse: links