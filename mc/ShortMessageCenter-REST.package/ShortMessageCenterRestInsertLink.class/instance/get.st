as yet unclassified
get
	| connectionName link |
	connectionName := variables first.

	"Try to materialize it"
	link := omDatabase findInserterLink: connectionName.
	link ifNil: [
		logger logNotice: 'Can not find connection' with: { 'connectionName' -> connectionName }.
		^self notFound].

	^self jsonResponse: link toExternalDictionary.