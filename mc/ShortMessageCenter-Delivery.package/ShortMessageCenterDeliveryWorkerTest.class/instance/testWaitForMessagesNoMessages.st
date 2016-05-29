tests-as yet unclassified
testWaitForMessagesNoMessages
	worker
		sleepTime: 0 seconds;
		waitForMessages.

	"Pass if there wasn't an exception. >>#shouldn:raise: creates an assert but
	doesn't make it any better."