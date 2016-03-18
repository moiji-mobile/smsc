as yet unclassified
exampleSubmitSMEncodedMessage
	| smppMessage |
	smppMessage := SMPPMessage readFrom: SMPPMessageTest new exampleSubmitSM readStream.
	^smppMessage body toMessage asByteArray