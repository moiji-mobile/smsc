as yet unclassified
initialize
	super initialize.
	logger := LogStructuredLogger for: self area: #smscDelivery.
	tcapLinks := Dictionary new.
	baseWorkerName := ''.