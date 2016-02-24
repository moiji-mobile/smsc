forward
createNewForwardDialogue
	| confirmed |
	"Create dialogue.. send it.. on _first_ continue call forwardMessage again...
	on end and abort..fail the rest"
	confirmed := false.
	deliveryDialogue := tcapLink newDialogue.
	deliveryDialogue
		onEnd: [
			deliveryDialogue := nil.
			"We wanted to do sometning but never heard back. For all other
			operations we have a ROS invocation that will work"
			confirmed ifFalse: [
				self signalForwardFailure: 'dialogue-end']];
		onPAbort: [
			deliveryDialogue := nil.
			confirmed ifFalse: [
				self signalForwardFailure: 'dialogue-pabort']];
		onUAbort: [
			deliveryDialogue := nil.
			confirmed ifFalse: [
				self signalForwardFailure: 'dialogue-uabort']].

	currentSMRPUI size > 100
		ifTrue: [
			deliveryDialogue
			onContinue: [
				confirmed ifFalse: [
					confirmed := true.
					self sendNextMessage]]]
		ifFalse: [
			confirmed := true.
			self forwardMessage].

	deliveryDialogue
		requestTcBeginDestinationAddress: self remoteSCCPAddressForForward
		originatingAddress: self localSCCPAddress
		applicationContextName: (deliveryDialogue applicationContextOidForOperationNamed:  self class forwardSMName).