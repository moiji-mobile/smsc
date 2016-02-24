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
			logger logError: 'SRIForSM p-aborted' with: {
				'smscId' -> (message at: '_id'). 'destMSISDN' -> (message at: 'destMSISDN') }.
			self failAllMessages];
		onUAbort: [
			logger logError: 'SRIForSM u-aborted' with: {
				'smscId' -> (message at: '_id'). 'destMSISDN' -> (message at: 'destMSISDN') }.
			self failAllMessages].
	invoke := tcapDialogue
				requestTcInvokeNamed: operationName parameters:  param
				class: 1 timeout: 60.
	invoke
		onReturn: [
			logger logError: 'SRIForSM on-return' with: {
				'smscId' -> (message at: '_id'). 'destMSISDN' -> (message at: 'destMSISDN') }.
			self failAllMessages];
		onError: [
			logger logError: 'SRIForSM on-error' with: {
				'smscId' -> (message at: '_id'). 'destMSISDN' -> (message at: 'destMSISDN') }.
			self failAllMessages];
		onReject: [
			logger logError: 'SRIForSM on-reject' with: {
				'smscId' -> (message at: '_id'). 'destMSISDN' -> (message at: 'destMSISDN') }.
			self failAllMessages];
		onLCancel: [
			logger logError: 'SRIForSM on-cancel' with: {
				'smscId' -> (message at: '_id'). 'destMSISDN' -> (message at: 'destMSISDN') }.
			self failAllMessages];
		onReturnLast: [:result | self handleSRIForSMResult: result].
	tcapDialogue
		requestTcBeginDestinationAddress: self remoteSCCPAddressForSRIForSM
		originatingAddress: self localSCCPAddress
		applicationContextName: (tcapDialogue applicationContextOidForOperationNamed: operationName).