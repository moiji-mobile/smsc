as yet unclassified
delete
	| connectionName |
	connectionName := variables first.

	"Try to materialize it"
	omDatabasePool withDatabase: [:db |
		| omDatabase link |
		omDatabase := ShortMessageOMDatabase withDatabase: db.
		link := omDatabase findDeliveryLink: connectionName.
		link ifNil: [
			logger logNotice: 'Can not find delivery SMPP connection' with: { 'connectionName' -> connectionName}.
			^self notFound].

		omDatabase removeDeliveryLink: link.
		self emptyOkResponse]