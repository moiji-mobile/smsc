as yet unclassified
converMessageToDeliverSM: aMessage 
	| data type  |
	data := aMessage at: 'encodedMessage'.
	type := aMessage at: 'encodedMessageType'.

	type = 'SMPPDeliverSM' ifTrue: [
		^SMPPDeliverSM new readFrom: data readStream].
	type = 'SMPPSubmitSM' ifTrue: [
		| submitSM |
		submitSM := SMPPSubmitSM new readFrom: data readStream.
		^self convertToDeliverSM: submitSM].

	"We foresee SS7 insertion as well"
	^self error: 'Unknown type ', type.

	