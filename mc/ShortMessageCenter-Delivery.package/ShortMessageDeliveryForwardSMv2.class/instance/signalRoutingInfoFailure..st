routing
signalRoutingInfoFailure: log
	| message |
	message := pendingMessages first.
	logger logError: 'SRIForSM failure' with: {
				'smscId' -> (message at: '_id'). 'destMSISDN' -> (message at: 'destMSISDN'). 'log' -> log }.
	self failAllMessages