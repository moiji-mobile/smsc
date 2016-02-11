smpp
addConnection: aConnection
	smppConnections add: aConnection.
	aConnection onUnhandledCommand: [:handler :command | self smppCommand: command from: handler].