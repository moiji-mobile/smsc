as yet unclassified
put
	| connectionName data link |
	connectionName := variables first.
	data := self jsonRequest.

	"Try to materialize it"
	link := ShortMessageLinkSS7Materializer new materialize: data.
	link ifNil: [
		logger logNotice: 'Can not materialize delivery SS7  connection' with: { 'connectionName' -> connectionName }.
		^self notFound].

	link connectionName: connectionName.
	omDatabase createOrUpdateDeliverySS7Link: link.
	self emptyOkResponse