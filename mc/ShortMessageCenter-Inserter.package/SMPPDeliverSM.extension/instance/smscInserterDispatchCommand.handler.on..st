*ShortMessageCenter-Inserter
smscInserterDispatchCommand: aSmppMessage handler: aHandler on: aServer
	^aServer handleDeliverSM: aSmppMessage handler: aHandler