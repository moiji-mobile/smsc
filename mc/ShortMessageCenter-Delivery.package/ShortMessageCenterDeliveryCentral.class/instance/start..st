as yet unclassified
start: numJobs
	| root database |

	"Open the DB and "
	root := Mongo host: dbHost port: dbPort.
	database := MongoDatabase root: root name: omDatabaseName.
	root open.

	omDatabase := ShortMessageOMDatabase withDatabase: database.
	self startSmppLinks.
	self startSS7Links.
	root close.

	workers := Array new: numJobs.
	1 to: numJobs do: [:each |
		| proc worker |
		worker := ShortMessageCenterDeliveryWorker new.
		worker
			workerName: baseWorkerName , ' Worker', each asString;
			deliveryCentral: self.
		proc := [
			worker
				databaseHost: dbHost port: dbPort omName: omDatabaseName smscName: smscDatabaseName;
				doWork ] newProcess.
		proc name: 'Worker ', each asString.
		workers at: each put: proc].

	workers do: [:each |
		each resume].