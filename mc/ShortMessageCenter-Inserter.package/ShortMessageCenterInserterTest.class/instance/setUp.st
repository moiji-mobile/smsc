as yet unclassified
setUp
	mockConnection := SMPPMockConnection new.
	smscDatabase := MockShortMessageDatabase new.
	smscInserter := ShortMessageCenterInserter new.
	smscInserter smppConnection: mockConnection.
	smscInserter smscDatabase: smscDatabase.