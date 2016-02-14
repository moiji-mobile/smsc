as yet unclassified
get
	| links |
	links := omDatabase allDeliverySS7Links.
	links := links collect: [:each | each toExternalDictionary ].
	self jsonResponse: links