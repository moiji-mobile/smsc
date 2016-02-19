as yet unclassified
start: numJobs
	| root database |

	"Open the DB and "
	root := Mongo host: dbHost port: dbPort.
	database := MongoDatabase root: root name: dbName.
	root open.

	omDatabase := ShortMessageOMDatabase withDatabase: database.
	self loadRoutes.
	self startSmppLinks.
	self startSs7Links.

	workers := Array new: numJobs.
	1 to: numJobs do: [:each |
		| proc worker |
		worker := ShortMessageCenterDeliveryWorker new.
		worker databaseHost: dbHost port: dbPort name: dbName.
		worker workerName: baseWorkerName + ' Worker' + each asString.
		proc := [ worker setup. worker doWork ] newProcess.
		proc name: 'Worker ', each asString.
		workers at: each put: proc].

	workers do: [:each |
		each resume].