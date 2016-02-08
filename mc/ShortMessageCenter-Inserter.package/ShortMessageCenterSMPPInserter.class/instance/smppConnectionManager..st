smpp
smppConnectionManager: aConnectionManager
	smppConnectionManager := aConnectionManager.
	smppConnectionManager onUnhandledCommand: [:handler :command | self smppCommand: command from: handler].