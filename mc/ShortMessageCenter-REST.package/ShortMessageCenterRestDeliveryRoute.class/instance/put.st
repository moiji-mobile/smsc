as yet unclassified
put
	| routeName data route |
	routeName := variables first.
	data := self jsonRequest.
	data at: 'routeName' put: routeName.

	"Try to materialize it"
	route := ShortMessageRouteMaterializer new materialize: data.
	route ifNil: [
		logger logNotice: 'Can not materialize delivery route' with: { 'routeName' -> routeName }.
		^self notFound].

	route routeName: routeName.
	omDatabasePool withSmscOmDatabase: [:omDatabase |
		omDatabase createOrUpdateDeliveryRoute: route].
	self emptyOkResponse