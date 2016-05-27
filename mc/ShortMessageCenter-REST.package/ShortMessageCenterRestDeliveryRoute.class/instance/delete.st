as yet unclassified
delete
	| routeName |
	routeName := variables first.

	"Try to materialize it"
	omDatabasePool withDatabase: [:db |
		| omDatabase route |
		omDatabase := ShortMessageOMDatabase withDatabase: db.
		route := omDatabase findDeliveryRoute: routeName.
		route ifNil: [
			logger logNotice: 'Can not find delivery route' with: { 'routeName' -> routeName }.
			^self notFound].

		omDatabase removeDeliveryRoute: route.
		self emptyOkResponse.
	].