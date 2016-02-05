as yet unclassified
createInsertNotificationCollection: aDatabase
	aDatabase addCollection: 'insertNotification' capped: true size: 1000 max: 100.