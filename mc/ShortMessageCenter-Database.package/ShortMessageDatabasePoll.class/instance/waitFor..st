as yet unclassified
waitFor: aDurationAsSeconds
	| query tailableCursor lastItem |
	query := MongoQuery new
		database: database;
		collection: collection;
		doBlock: [:each | lastItem := each ];
		yourself.

	"
	1.) Set-up the tailable cursor
	2.) Check if there is any event
	3.) Wait on the tailable cursor. It currently wakes up
	earlier than our timeout and we can optimize this later.
	"
	tailableCursor := MongoTailableCursor new
		query: query;
		root: root;
		yourself.
	tailableCursor create.
	self smsPending ifTrue: [
		^self].
	tailableCursor requestNext.

	root stream socket waitForDataFor: aDurationAsSeconds
		ifClosed: [ self halt ] ifTimedOut: [ self halt ].
	tailableCursor readNext. 