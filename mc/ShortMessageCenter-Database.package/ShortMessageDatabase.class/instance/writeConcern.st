as yet unclassified
writeConcern
	"See checkLastError"
	^{
		'w' -> 'majority'.
		'wtimeout' -> 5000.
	} asDictionary