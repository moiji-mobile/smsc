as yet unclassified
default
	| root database |
	root := Mongo local.
	root open.
	database := MongoDatabase root: root name: 'smscOM'.
	^self withDatabase: database.
