*ShortMessageCenter-Inserter
smscInserterDispatchCommand: aSmppMessage handler: aHandler on: aServer
	^aServer handleSubmitSM: aSmppMessage handler: aHandler