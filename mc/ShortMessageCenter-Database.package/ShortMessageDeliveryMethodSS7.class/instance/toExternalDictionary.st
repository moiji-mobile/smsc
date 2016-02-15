as yet unclassified
toExternalDictionary
	^{
		'class' -> self class name asString.
		'connectionName' -> connectionName.
		'globalTitle' -> globalTitle.
		'smscNumber' -> smscNumber.
		'sendRoutingInfoTranslationType' -> sendRoutingInfoTranslationType.
		'forwardSMTranslationType' -> forwardSMTranslationType.
		'mapVersion' -> mapVersion} asDictionary.