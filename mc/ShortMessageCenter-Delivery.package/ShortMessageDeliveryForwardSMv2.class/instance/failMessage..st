result
failMessage: aMessage
	super failMessage: aMessage.
	pendingMessages remove: aMessage.
	pendingMessages isEmpty ifTrue: [
		waitingSemaphore signal].