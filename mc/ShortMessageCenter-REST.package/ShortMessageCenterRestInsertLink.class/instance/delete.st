as yet unclassified
delete
	| connectionName link |
	connectionName := variables first.

	"Try to materialize it"
	link := omDatabase findInserterLink: connectionName.
	link ifNil: [
		logger logNotice: 'Can not find connection' with: { 'connectionName' -> connectionName }.
		^self notFound].

	omDatabase removeInserterLink: link.
	self emptyOkResponse.