as yet unclassified
setUp
	mockConnection := SMPPMockConnection new.
	smscDatabase := MockShortMessageDatabase new.
	smscInserter := ShortMessageCenterInserter new.
	smscInserter addConnection: mockConnection.
	smscInserter smscDatabasePool: (MockShortMessageDatabasePool withDatabase: smscDatabase).