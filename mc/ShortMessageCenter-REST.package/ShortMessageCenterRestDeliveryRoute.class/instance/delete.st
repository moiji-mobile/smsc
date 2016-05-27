as yet unclassified
delete
	| routeName |
	routeName := variables first.

	"Try to materialize it"
	omDatabasePool withSmscOmDatabase: [:omDatabase |
		| route |
		route := omDatabase findDeliveryRoute: routeName.
		route ifNil: [
			logger logNotice: 'Can not find delivery route' with: { 'routeName' -> routeName }.
			^self notFound].

		omDatabase removeDeliveryRoute: route.
		self emptyOkResponse.
	].