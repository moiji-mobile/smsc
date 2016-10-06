as yet unclassified
queryOnce
	ModuleBoundary runSynchronous: [
		[
			[
				root isOpen ifFalse: [ root open ].
				lastReturnCount := nil.
				self doQueryOnce.
			] ifCurtailed: [
				root close]
		] ensure: [
			self dispatchAll]]