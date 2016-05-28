as yet unclassified
converMessageToSubmitSM: aMessage 
	| data type  |
	data := aMessage at: 'encodedMessage'.
	type := aMessage at: 'encodedMessageType'.

	type = 'SMPPSubmitSM' ifTrue: [
		^SMPPSubmitSM new readFrom: data readStream].
	type = 'SMPPDeliverSM' ifTrue: [
		| deliverSM |
		deliverSM := SMPPDeliverSM new readFrom: data readStream.
		^self convertToSubmitSM: deliverSM].

	"We foresee SS7 insertion as well"
	^self error: 'Unknown type ', type.

	