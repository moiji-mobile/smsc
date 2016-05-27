as yet unclassified
put
	| connectionName data |
	connectionName := variables first.
	data := self jsonRequest.
	data at: 'connectionName' put: connectionName.

	"Try to materialize it"
	omDatabasePool withSmscOmDatabase: [:omDatabase |
		| link |
		link := ShortMessageLinkSMPPMaterializer new materialize: data.
		link ifNil: [
			logger logNotice: 'Can not materialize inserter SMPP connection' with: { 'connectionName' -> connectionName }.
			^self notFound].

		link connectionName: connectionName.
		omDatabase createOrUpdateInserterLink: link.
		self emptyOkResponse].