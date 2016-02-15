as yet unclassified
get
	| routeName route |
	routeName := variables first.

	"Try to materialize it"
	route := omDatabase findDeliveryRoute: routeName.
	route ifNil: [
		logger logNotice: 'Can not find delivery route' with: { 'routeName' -> routeName }.
		^self notFound].

	^self jsonResponse: route toExternalDictionary.