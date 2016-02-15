as yet unclassified
put
	| routeName data route |
	routeName := variables first.
	data := self jsonRequest.

	"Try to materialize it"
	route := ShortMessageRouteMaterializer new materialize: data.
	route ifNil: [
		logger logNotice: 'Can not materialize delivery route' with: { 'routeName' -> routeName }.
		^self notFound].

	route routeName: routeName.
	omDatabase createOrUpdateDeliveryRoute: route.
	self emptyOkResponse