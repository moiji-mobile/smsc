*ShortMessageCenter-Database
withSmscDatabase: aBlock
	^self withDatabase: [:db | aBlock value: (ShortMessageDatabase withDatabase: db)]