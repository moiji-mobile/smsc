as yet unclassified
exampleEncodedSubmitMessage
	| smppMessage |
	smppMessage := SMPPMessage readFrom: SMPPMessageTest new exampleSubmitSM readStream.
	^smppMessage body toMessage asByteArray