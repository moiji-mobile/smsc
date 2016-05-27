as yet unclassified
get
	| connectionName |
	connectionName := variables first.

	"Try to materialize it"
	omDatabasePool withSmscOmDatabase: [:omDatabase |
		| link |
		link := omDatabase findInserterLink: connectionName.
		link ifNil: [
			logger logNotice: 'Can not find inserter SMPP connection' with: { 'connectionName' -> connectionName }.
			^self notFound].

		^self jsonResponse: link toExternalDictionary].