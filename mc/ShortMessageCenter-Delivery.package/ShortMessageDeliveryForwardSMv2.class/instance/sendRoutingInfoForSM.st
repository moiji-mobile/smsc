routing
sendRoutingInfoForSM
	| message tcapDialogue operationName operation param invoke |
	
	"If this fails all messages will fail, we will not re-try this. If it gives
	us a MSC number and IMSI we can continue"

	message := messages first.
	tcapDialogue := tcapLink newDialogue.
	operationName := 'sendRoutingInfoForSMV2'.
	operation := tcapDialogue rosOperationNamed: operationName.
	param := operation newArgumentValue
			at: 'msisdn' put: (message at: 'destMSISDN');
			at: 'sm-RP-PRI' put: true;
			at: 'serviceCentreAddress' put: smscNumber toE164;
			yourself.

	tcapDialogue
		onPAbort: [
			self signalRoutingInfoFailure: 'on-pabort'];
		onUAbort: [
			self signalRoutingInfoFailure: 'on-uabort'].
	invoke := tcapDialogue
				requestTcInvokeNamed: operationName parameters:  param class: 1 timeout: timerM.
	invoke
		onReturn: [
			self signalRoutingInfoFailure: 'on-return'];
		onError: [
			self signalRoutingInfoFailure: 'on-error'];
		onReject: [
			self signalRoutingInfoFailure: 'on-reject'];
		onLCancel: [
			self signalRoutingInfoFailure: 'on-cancel'];
		onReturnLast: [:result | self handleSRIForSMResult: result].
	tcapDialogue
		requestTcBeginDestinationAddress: self remoteSCCPAddressForSRIForSM
		originatingAddress: self localSCCPAddress
		applicationContextName: (tcapDialogue applicationContextOidForOperationNamed: operationName).