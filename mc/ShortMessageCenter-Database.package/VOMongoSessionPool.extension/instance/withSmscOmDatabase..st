*ShortMessageCenter-Database
withSmscOmDatabase: aBlock
	^self withDatabase: [:db | aBlock value: (ShortMessageOMDatabase withDatabase: db)]