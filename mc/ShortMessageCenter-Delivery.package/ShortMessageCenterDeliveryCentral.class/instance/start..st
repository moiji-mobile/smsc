as yet unclassified
start: numJobs
	| root database notifierDatabase notifierCollection |

	"Open the DB and "
	root := Mongo host: dbHost port: dbPort.
	database := MongoDatabase root: root name: omDatabaseName.
	root open.

	omDatabase := ShortMessageOMDatabase withDatabase: database.
	self startSmppLinks.
	self startSS7Links.
	omDatabase := nil.

	notifierDatabase := root databaseNamed: smscDatabaseName.
	notifierCollection := MongoCollection database: notifierDatabase name: 'insertNotification'.
	notifier := ShortMessageNotifier new
						database: notifierDatabase collectionForNotification: notifierCollection;
						yourself.

	workers := Array new: numJobs.
	1 to: numJobs do: [:each |
		| proc worker |
		worker := ShortMessageCenterDeliveryWorker new.
		worker
			workerName: baseWorkerName , ' Worker', each asString;
			deliveryCentral: self.
		proc := [
			worker
				notifier: notifier;
				databaseHost: dbHost port: dbPort omName: omDatabaseName smscName: smscDatabaseName;
				doWork ] newProcess.
		proc name: 'Worker ', each asString.
		workers at: each put: proc].

	workers do: [:each |
		each resume].