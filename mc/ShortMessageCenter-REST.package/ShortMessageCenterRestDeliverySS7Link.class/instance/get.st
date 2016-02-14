as yet unclassified
get
	| connectionName link |
	connectionName := variables first.

	"Try to materialize it"
	link := omDatabase findDeliverySS7Link: connectionName.
	link ifNil: [
		logger logNotice: 'Can not find delivery SS7 connection' with: { 'connectionName' -> connectionName }.
		^self notFound].

	^self jsonResponse: link toExternalDictionary.