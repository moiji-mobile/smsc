polling
waitFor: aDurationAsSeconds
	| query tailableCursor lastItem |
	query := MongoQuery new
		database: database;
		collection: collectionForNotification;
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
		ifClosed: [ self reopenDatabase. ^self] ifTimedOut: [
			"This is more messy. Even if a request has an identifier MongoTalk
			does not make use of it. We now want to forget about the request we
			made but that means another reply will be messed up. Let's avoid this
			for now but it requires work."
			self flag: #todo. "See above"
			self reopenDatabase.
			^self].
	tailableCursor readNext.

	"Either mongod after ~2s timed out or new work is there. let's have a look"