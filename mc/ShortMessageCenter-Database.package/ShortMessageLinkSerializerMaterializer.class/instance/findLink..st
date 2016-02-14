api
findLink: aName
	| result |
	result := collection queryOne: [:query |
					query where: [:item | item connectionName = aName ] ].
	^result ifNotNil: [materializer materialize: result]