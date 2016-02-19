as yet unclassified
setup
	smscDatabase := ShortMessageDatabase withDatabase: database.
	omDatabase := ShortMessageOMDatabase withDatabase: database.
	messagesSelector := ShortMessageCenterMessagesSelector new
								smscDatabase: smscDatabase;
								workerName: workerName;
								yourself.