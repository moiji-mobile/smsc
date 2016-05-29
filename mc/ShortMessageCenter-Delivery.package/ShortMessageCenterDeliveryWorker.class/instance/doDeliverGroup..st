as yet unclassified
doDeliverGroup: aGroup
	| route messages |
	"Log before we materialize the route"
	logger logNotice: 'Attempting to deliver to group' with: {
		'routeName' -> (aGroup route at: 'routeName').
		'messages' -> aGroup messages size.
		'destMSISDN' -> (aGroup messages first at: 'destMSISDN') }.

	route := ShortMessageDeliveryRoute materializeFrom: aGroup route.
	messages := aGroup messages.

	route methods do: [:method |
		"Execute the delivery and wait...We can borrow the smscDatabase
		to the delivery as we are blocking until the usage has terminated"
		method createDelivery
			messages: messages;
			deliveryCentral: deliveryCentral;
			smscDatabase: smscDatabase;
			blockingExecute.
		messages isEmpty ifTrue: [^self]].