as yet unclassified
get
	| connectionName |
	connectionName := variables first.

	"Try to materialize it"
	omDatabasePool withSmscOmDatabase: [:omDatabase |
		| link |
		link := omDatabase findDeliverySS7Link: connectionName.
		link ifNil: [
			logger logNotice: 'Can not find delivery SS7 connection' with: { 'connectionName' -> connectionName }.
			^self notFound].

		^self jsonResponse: link toExternalDictionary].