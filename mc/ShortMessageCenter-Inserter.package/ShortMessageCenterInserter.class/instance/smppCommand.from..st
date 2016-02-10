smpp
smppCommand: aSmppMessage from: aHandler
	aSmppMessage body smscInserterDispatchCommand: aSmppMessage handler: aHandler on: self