as yet unclassified
get
	| links |
	links := omDatabase allDeliveryRoutes.
	links := links collect: [:each | each toExternalDictionary ].
	self jsonResponse: links