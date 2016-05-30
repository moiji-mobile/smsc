forward
createNewForwardDialogue
	deliveryDialogue ifNotNil: [
		self logError: 'deliveryDialogue should have been cleared' with: {'imsi' -> imsi}.
		self cancelDialogueTimer].

	dialogueConfirmed := false.
	deliveryDialogue := tcapLink newDialogue.
	deliveryDialogue
		onEnd: [
			"We wanted to do sometning but never heard back. For all other
			operations we have a ROS invocation that will work"
			dialogueConfirmed ifFalse: [
				self signalForwardFailure: 'dialogue-end']];
		onPAbort: [
			dialogueConfirmed ifFalse: [
				self signalForwardFailure: 'dialogue-pabort']];
		onUAbort: [
			dialogueConfirmed ifFalse: [
				self signalForwardFailure: 'dialogue-uabort']].

	currentSMRPUI size > maxSMRPUISize
		ifTrue: [
			deliveryDialogue
				onContinue: [
					dialogueConfirmed ifFalse: [
						dialogueConfirmed := true.
						self cancelDialogueTimer.
						self sendNextMessage]].
			dialogueTimer := TimerScheduler instance
									scheduleIn: timerM asDuration block: [
										deliveryDialogue ifNotNil: [
											self signalForwardFailure: 'dialogue-not-confirmed']]]
		ifFalse: [
			dialogueConfirmed := true.
			self forwardMessage].

	deliveryDialogue
		requestTcBeginDestinationAddress: self remoteSCCPAddressForForward
		originatingAddress: self localSCCPAddress
		applicationContextName: (deliveryDialogue applicationContextOidForOperationNamed: self class forwardSMName).