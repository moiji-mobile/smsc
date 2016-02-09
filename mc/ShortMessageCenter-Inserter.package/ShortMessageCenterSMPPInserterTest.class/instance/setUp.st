as yet unclassified
setUp
	mockConnection := SMPPMockConnection new.
	smscDatabase := MockShortMessageDatabase new.
	smscInserter := ShortMessageCenterSMPPInserter new.
	smscInserter smppConnection: mockConnection.
	smscInserter smscDatabase: smscDatabase.