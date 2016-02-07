sms-read
nextSms
	"Return the time of the closest unlocked item"
	^collectionForSms queryOne: [:query |
		query where: [:item | item lock = 0].
		query order: [:item | item deliveryTime = Mongo ascending] asMongoQuery]