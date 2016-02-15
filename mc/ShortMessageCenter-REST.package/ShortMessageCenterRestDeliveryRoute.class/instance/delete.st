as yet unclassified
delete
	| routeName route |
	routeName := variables first.

	"Try to materialize it"
	route := omDatabase findDeliveryRoute: routeName.
	route ifNil: [
		logger logNotice: 'Can not find delivery route' with: { 'routeName' -> routeName }.
		^self notFound].

	omDatabase removeDeliveryRoute: route.
	self emptyOkResponse.