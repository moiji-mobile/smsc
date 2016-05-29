as yet unclassified
createInsertNotificationCollection: aDatabase
	| coll |

	"Add the collection and an entry if it doesn't exist. If it exists
	there will be an exception and we are done."
	coll := aDatabase addCollection: 'insertNotification' capped: true size: 1000 max: 100.

	coll add: { 'first entry' -> 1 } asDictionary.
	aDatabase command: { 'getLastError' -> 1. 'w' -> 'majority'. 'wtimeout' -> 5000. 'j' -> true.} asDictionary