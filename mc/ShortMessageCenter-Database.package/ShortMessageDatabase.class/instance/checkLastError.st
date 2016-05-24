as yet unclassified
checkLastError
	database command: {
		'getLastError' -> 1.
		'w' -> 'majority'.
		'wtimeout' -> 5000.
	} asDictionary