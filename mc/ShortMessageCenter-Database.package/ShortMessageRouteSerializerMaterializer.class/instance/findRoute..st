api
findRoute: aName
	| result |
	result := collection queryOne: [:query |
					query where: [:item | item routeName = aName ] ].
	^result ifNotNil: [materializer materialize: result]