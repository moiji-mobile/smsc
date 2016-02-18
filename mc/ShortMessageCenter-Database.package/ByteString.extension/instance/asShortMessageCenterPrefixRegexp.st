*ShortMessageCenter-Database
asShortMessageCenterPrefixRegexp
	^self class streamContents: [:stream |
		| remainingLen |
		stream
			nextPut: $^;
			nextPutAll: (self copyFrom: 1 to: 2);
			nextPut: $(.

		remainingLen := self size - 2.
		1 to: remainingLen do: [:len |
			1 to: len do: [:off |
				stream nextPut: (self at: 2 + off)].
			len = remainingLen ifFalse: [stream nextPut: $|]].
		stream nextPutAll: ')$']