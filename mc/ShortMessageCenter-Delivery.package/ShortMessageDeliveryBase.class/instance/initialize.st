as yet unclassified
initialize
	super initialize.
	logger := LogStructuredLogger for: self area:#smscDelivery.
	converter := ShortMessageCenterConverter new.