as yet unclassified
delete
	| connectionName |
	connectionName := variables first.

	"Try to materialize it"
	omDatabasePool withDatabase: [:db |
		| omDatabase link |
		omDatabase := ShortMessageOMDatabase withDatabase: db.
		link := omDatabase findInserterLink: connectionName.
		link ifNil: [
			logger logNotice: 'Can not find inserter SMPP connection' with: { 'connectionName' -> connectionName }.
			^self notFound].

		omDatabase removeInserterLink: link.
		self emptyOkResponse].