consistency
writeConcern
	"See checkLastError"
	^{
		'w' -> 'majority'.
		'wtimeout' -> 5000.
		'j' -> true.
	} asDictionary