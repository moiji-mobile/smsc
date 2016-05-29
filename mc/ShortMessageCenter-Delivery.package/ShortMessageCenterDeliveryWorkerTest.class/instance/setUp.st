as yet unclassified
setUp
	| root database |
	root := Mongo local.
	root open.
	database := MongoDatabase root: root name: 'smscTest'.
	"Remove the database before we start"
	database drop.
	root close.
	worker := ShortMessageCenterDeliveryWorker new
					workerName: 'TestCaseWorker';
					databaseHost: 'localhost' port: 27017 omName: 'smscTest' smscName: 'smscTest'. 