forward
createNewForwardDialogue
	| delayedInvocation |
	deliveryDialogue ifNotNil: [
		self logError: 'deliveryDialogue should have been cleared' with: {'imsi' -> imsi}].

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

	delayedInvocation := currentSMRPUI size > maxSMRPUISize.
	delayedInvocation
		ifTrue: [
			deliveryDialogue
				onContinue: [
					dialogueConfirmed ifFalse: [
						dialogueConfirmed := true.
						deliveryDialogue requestTcContinue]]]
		ifFalse: [
			dialogueConfirmed := true.
			self forwardMessage].

	deliveryDialogue
		requestTcBeginDestinationAddress: self remoteSCCPAddressForForward
		originatingAddress: self localSCCPAddress
		applicationContextName: (deliveryDialogue applicationContextOidForOperationNamed: self class forwardSMName).

	"Now place a component in it that will be flushed later but the timer will already run."
	delayedInvocation ifTrue: [self forwardMessage].