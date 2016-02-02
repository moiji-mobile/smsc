accessing
project
	^ project
		ifNil: [ 
			(self class baseConfigurationClassIfAbsent: [ nil ]) ensureMetacello.
			project := MetacelloMCProject new projectAttributes: self customProjectAttributes.
			(Smalltalk at: #MetacelloVersionConstructor) on: self project: project.
			project loadType: #linear.
			project ]