as yet unclassified
smppLinkByName: aName
	smppDeliveryLinks do: [:each |
		each connectionName = aName ifTrue: [^each]].
	^nil