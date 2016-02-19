as yet unclassified
selectMessages
	"I try to return a list of to be sent messages and lock them. In case either nothing
	can be locked or none is available nil will be returned."

	| rejected |
	rejected := OrderedCollection new.

	[
		| initialMessage destMSISDN destination |
		initialMessage := smscDatabase findAndLockPendingSms: workerName reject: rejected.
		initialMessage ifNil: [
			^nil].

		destMSISDN := initialMessage at: 'destMSISDN'.
		logger logNotice: 'Locked first message' with: {
			'workerName' -> workerName. 'dest' -> destMSISDN }.

		"Attempt to lock this target now"
		destination := self lockDestination: destMSISDN for: workerName.
		destination isNil
			ifTrue: [
				"Somebody tries to deliver there. Let us skip it and try again"
				rejected add: destMSISDN.
				logger logNotice: 'Could not lock destination' with: {
					'workerName' -> workerName. 'dest' -> destMSISDN}.
				smscDatabase unlockSms: (initialMessage at: '_id') for: workerName]
			ifFalse: [
				"We may go ahead and try to lock more SMS here. Let's say up to 5"
				^self selectMoreMessages: initialMessage.
			].
	] repeat.
