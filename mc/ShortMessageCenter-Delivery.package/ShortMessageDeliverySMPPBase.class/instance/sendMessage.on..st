as yet unclassified
sendMessage: aMessage on: aConnection
	| command |

	command := self createCommandForMessage: aMessage.
	command
		setTimeout: 5;
		onTimeout: [
			logger logError: 'Timeout for message' with: { 'smsId' -> (aMessage at: '_id') }.
			self failMessage: aMessage];
		onError: [:err |
			logger logError: 'Error on SMPP' with: { 'smsId' -> (aMessage at: '_id')}.
			self failMessage: aMessage];
		onResult: [:res |
			self deliveredMessage: aMessage].
	aConnection scheduleCommand: command.