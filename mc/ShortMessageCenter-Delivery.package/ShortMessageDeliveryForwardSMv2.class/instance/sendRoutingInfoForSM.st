routing
sendRoutingInfoForSM
	| message operationName operation param invoke |
	
	"If this fails all messages will fail, we will not re-try this. If it gives
	us a MSC number and IMSI we can continue"

	message := messages first.
	sriSMDialogue := tcapLink newDialogue.
	operationName := 'sendRoutingInfoForSMV2'.
	operation := sriSMDialogue rosOperationNamed: operationName.
	param := operation newArgumentValue
			at: 'msisdn' put: (message at: 'destMSISDN');
			at: 'sm-RP-PRI' put: true;
			at: 'serviceCentreAddress' put: smscNumber toE164;
			yourself.

	sriSMDialogue
		onPAbort: [
			self signalRoutingInfoFailure: 'on-pabort'];
		onUAbort: [
			self signalRoutingInfoFailure: 'on-uabort'].
	invoke := sriSMDialogue
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
	sriSMDialogue
		requestTcBeginDestinationAddress: self remoteSCCPAddressForSRIForSM
		originatingAddress: self localSCCPAddress
		applicationContextName: (sriSMDialogue applicationContextOidForOperationNamed: operationName).