as yet unclassified
put
	| connectionName data link |
	connectionName := variables first.
	data := self jsonRequest.
	data at: 'connectionName' put: connectionName.

	"Try to materialize it"
	link := ShortMessageLinkSMPPMaterializer new materialize: data.
	link ifNil: [
		logger logNotice: 'Can not delivery SMPP materialize connection' with: { 'connectionName' -> connectionName }.
		^self notFound].

	link connectionName: connectionName.
	omDatabase createOrUpdateDeliveryLink: link.
	self emptyOkResponse