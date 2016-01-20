as yet unclassified
waitUntil: aDateTime
	| now duration |
	now := DateAndTime now.
	duration := (aDateTime - now) asSeconds.
	duration < 0 ifTrue: [
		^self].

	self waitFor: duration.