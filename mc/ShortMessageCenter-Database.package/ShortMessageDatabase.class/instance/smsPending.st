as yet unclassified
smsPending
	| pending |
	"Maybe a find with limit is better?"
	pending := collectionForSms queryOne: [:query | query where: [:each | each deliveryTime <= DateAndTime now]].
	^pending isNil not.