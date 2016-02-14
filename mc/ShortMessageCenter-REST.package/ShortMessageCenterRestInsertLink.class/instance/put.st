as yet unclassified
put
	| connectionName data link |
	connectionName := variables first.
	data := self jsonRequest.

	"Try to materialize it"
	link := ShortMessageLinkSMPPMaterializer new materialize: data.
	link ifNil: [
		logger logNotice: 'Can not materialize inserter SMPP connection' with: { 'connectionName' -> connectionName }.
		^self notFound].

	link connectionName: connectionName.
	omDatabase createOrUpdateInserterLink: link.
	self emptyOkResponse