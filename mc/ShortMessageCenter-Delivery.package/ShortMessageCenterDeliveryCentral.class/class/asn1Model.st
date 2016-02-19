map
asn1Model
	^ asn1Model ifNil: [ 
		asn1Model := self defaultAsn1Model ] 