notification
addNewShortMessageNotification: aMessage
	"This will be inserted into a cap collection and should lead to a wakeup"
	| record |

	record := {
		'type' -> 'NewMesssage'.
		'date' -> DateAndTime now.
		'message' -> aMessage
	} asDictionary.
	logger logDebug: 'Adding notification' with: { 'msg' -> aMessage }.
	collectionForNotification add: record.