*ShortMessageCenter-Delivery
createDelivery
	| class |
	class := messageType = 'submitSM'
					ifTrue: [ ShortMessageDeliverySMPPSubmitSM ]
					ifFalse: [ ShortMessageDeliverySMPPDeliverSM ].
	^class new
		connectionName: connectionName;
		yourself