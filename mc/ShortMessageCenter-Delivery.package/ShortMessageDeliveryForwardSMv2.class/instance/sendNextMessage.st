forward
sendNextMessage
	"Take the first message and format it. Then see how we can send it"
	currentSMRPUI := self formatMessage.

	deliveryDialogue ifNil: [
		^self createNewForwardDialogue].
	self forwardMessage.
	deliveryDialogue requestTcContinue.