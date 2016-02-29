forward
sendNextMessage
	"Take the first message and format it. Then see how we can send it"
	currentSMRPUI := self formatMessage.

	deliveryDialogue ifNil: [
		^self createNewForwardDialogue].

	(deliveryDialogue state respondsTo: #requestTcContinue) ifFalse: [
		"Dialogue is going to end.. and the tcap stack does not tell us yet. OW#1583 has been
		filed for this."
		deliveryDialogue := nil.
		^self createNewForwardDialogue].

	self forwardMessage.
	deliveryDialogue requestTcContinue.