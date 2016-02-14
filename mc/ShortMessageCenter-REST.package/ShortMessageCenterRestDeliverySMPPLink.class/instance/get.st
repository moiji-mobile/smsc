as yet unclassified
get
	| connectionName link |
	connectionName := variables first.

	"Try to materialize it"
	link := omDatabase findDeliveryLink: connectionName.
	link ifNil: [
		logger logNotice: 'Can not find delivery SMPP connection' with: { 'connectionName' -> connectionName }.
		^self notFound].

	^self jsonResponse: link toExternalDictionary.