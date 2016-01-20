as yet unclassified
smsPending
	| pending |
	"Maybe a find with limit is better?"
	pending := collectionForSms queryOne: [:each | each nextDeliveryTime <= DateAndTime now].
	^pending isNil not.