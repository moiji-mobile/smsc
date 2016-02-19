as yet unclassified
selectMoreMessages: initialMessage
	| destMSISDN messages messagesIds |
	messages := OrderedCollection new.
	messagesIds := OrderedCollection new.
	messages add: initialMessage.
	messagesIds add: (initialMessage at: '_id').
	destMSISDN := initialMessage at: 'destMSISDN'.

	1 to: 5 do: [:each |
		| nextSms |
		nextSms := smscDatabase lockNextSms: destMSISDN for: workerName locked: messagesIds.
		nextSms ifNil: [^messages].

		messages add: nextSms.
		messagesIds add: (nextSms at: '_id').
	].
	^messages