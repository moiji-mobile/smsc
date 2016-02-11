as yet unclassified
start
	| links |

	"This is not the event/message flow model I want. In theory unhandledCommands
	of SMPP should be fed into a blocking queue and then we should have an instance
	of this class read from it. The SMPP connection itself should not be threaded
	either and use the delegation."
	self flag: #todo. "See the above comment"

	links := omDatabase allInserterLinks.
	links do: [:link |
		self addConnection: link.
		link start].