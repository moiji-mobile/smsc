as yet unclassified
put
	| connectionName data |
	connectionName := variables first.
	data := self jsonRequest.
	data at: 'connectionName' put: connectionName.

	"Try to materialize it"
	omDatabasePool withDatabase: [:db |
		| omDatabase link |
		omDatabase := ShortMessageOMDatabase withDatabase: db.
		link := ShortMessageLinkSS7Materializer new materialize: data.
		link ifNil: [
			logger logNotice: 'Can not materialize delivery SS7  connection' with: { 'connectionName' -> connectionName }.
			^self notFound].

		link connectionName: connectionName.
		omDatabase createOrUpdateDeliverySS7Link: link.
		self emptyOkResponse].