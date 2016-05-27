consistency
checkLastError
	database command: {
		'getLastError' -> 1.
		'w' -> 'majority'.
		'wtimeout' -> 5000.
		'j' -> true.
	} asDictionary