result
deliveredMessage: aMessage
	super deliveredMessage: aMessage.
	pendingMessages remove: aMessage.
	pendingMessages isEmpty ifTrue: [
		waitingSemaphore signal].