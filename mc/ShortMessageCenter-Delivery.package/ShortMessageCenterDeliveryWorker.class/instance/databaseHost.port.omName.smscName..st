as yet unclassified
databaseHost: dbHost port: dbPort omName: aOmName smscName: aSmscName
	"Share one root as we do not have nested queries from om to
	smsc or such"
	root := Mongo host: dbHost port: dbPort.
	root open.

	smscDatabase := ShortMessageDatabase withDatabase: (root databaseNamed: aSmscName).
	smscDatabase notifier: notifier.

	omDatabase := ShortMessageOMDatabase withDatabase: (root databaseNamed: aOmName).
	messagesSelector := ShortMessageCenterMessagesSelector new
								smscDatabase: smscDatabase;
								workerName: workerName;
								yourself.