as yet unclassified
toExternalDictionary
	^{
		'class' -> self class name asString.
		'connectionName' -> connectionName.
		'globalTitle' -> globalTitle.
		'ssn' -> ssn.
		'smscNumber' -> smscNumber.
		'sendRoutingInfoTranslationType' -> sendRoutingInfoTranslationType.
		'forwardSMTranslationType' -> forwardSMTranslationType.
		'mapVersion' -> mapVersion} asDictionary.