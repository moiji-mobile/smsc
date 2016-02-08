smpp
smppConnection: aConnection
	smppConnection := aConnection.
	smppConnection onUnhandledCommand: [:handler :command | self smppCommand: command from: handler].