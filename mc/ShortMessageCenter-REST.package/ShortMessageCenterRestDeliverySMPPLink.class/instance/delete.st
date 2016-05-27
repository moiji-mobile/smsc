as yet unclassified
delete
	| connectionName |
	connectionName := variables first.

	"Try to materialize it"
	omDatabasePool withSmscOmDatabase: [:omDatabase |
		| link |
		link := omDatabase findDeliveryLink: connectionName.
		link ifNil: [
			logger logNotice: 'Can not find delivery SMPP connection' with: { 'connectionName' -> connectionName}.
			^self notFound].

		omDatabase removeDeliveryLink: link.
		self emptyOkResponse]