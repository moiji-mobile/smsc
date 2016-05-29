result
unreachableMessage: aMessage
	super unreachableMessage: aMessage.
	pendingMessages remove: aMessage.
	pendingMessages isEmpty ifTrue: [
		waitingSemaphore signal].