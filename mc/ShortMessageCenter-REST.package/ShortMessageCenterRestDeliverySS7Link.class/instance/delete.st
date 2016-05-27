as yet unclassified
delete
	| connectionName |
	connectionName := variables first.

	"Try to materialize it"
	omDatabasePool withDatabase: [:db |
		| omDatabase link |
		omDatabase := ShortMessageOMDatabase withDatabase: db.
		link := omDatabase findDeliverySS7Link: connectionName.
		link ifNil: [
			logger logNotice: 'Can not find delivery SS7 connection' with: { 'connectionName' -> connectionName }.
			^self notFound].

		omDatabase removeDeliverySS7Link: link.
		self emptyOkResponse].