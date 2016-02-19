as yet unclassified
databaseHost: dbHost port: dbPort name: dbName
	root := Mongo host: dbHost port: dbPort.
	database := MongoDatabase root: root name: dbName.