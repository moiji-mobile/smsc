as yet unclassified
get
	| links |
	links := omDatabase allDeliveryLinks.
	links := links collect: [:each | each toExternalDictionary ].
	self jsonResponse: links