as yet unclassified
smppReturnSuccessOn: aHandler for: incomingMessage 
	| response |

	logger logNotice: 'Returning success' with: { 'systemId' -> aHandler systemId }.
	response := SMPPMessage new
					header: (SMPPPDUHeader new
						commandId: incomingMessage body responseForCommand;
						commandStatus: 0;
						sequenceNumber: incomingMessage header sequenceNumber;
						yourself);
					body: incomingMessage body responseSuccessBody.
	aHandler sendDirect: response toMessage asByteArray.