tests-sms-read
testFindAndLockPendingSmsReject
	| res |

	"No sms.. no result"
	res := smscDatabase findAndLockPendingSms: 'TestSystem' reject: #().
	self assert: res isNil.
	self deny: smscDatabase smsPending.

	"Sms from the future no result."
	smscDatabase insertShortMessage: 'bla' messageType: '123' destination: 'foo' source: 'moo' deliverIn: 10 hours expireIn: 2 days receivedOn: 'testLink'.
	res := smscDatabase findAndLockPendingSms: 'TestSystem' reject: #().
	self assert: res isNil.
	self deny: smscDatabase smsPending.

	smscDatabase insertShortMessage: 'foo' messageType: '123' destination: 'dest' source: 'moo' deliverIn: 0 seconds expireIn: 2 days receivedOn: 'testLink'.
	res := smscDatabase findAndLockPendingSms: 'TestSystem' reject: #().
	self deny: res isNil.
	self assert: (res at: 'destMSISDN') equals: 'dest'.
	self deny: smscDatabase smsPending.

	res := smscDatabase unlockSms: (res at: '_id').
	self deny: res isNil.
	self assert: (res at: 'lock') equals: 0.
	self assert: smscDatabase smsPending.

	"Second handling for targeted unlocking"
	self assert: smscDatabase smsPending.
	res := smscDatabase findAndLockPendingSms: 'TestSystem' reject: #().
	self deny: res isNil.
	self assert: (res at: 'destMSISDN') equals: 'dest'.
	self deny: smscDatabase smsPending.
	res := smscDatabase unlockSms: (res at: '_id') for: 'TestSystem'.
	self assert: smscDatabase smsPending.

	res := smscDatabase findAndLockPendingSms: 'TestSystem' reject: #('someDest' 'dest').
	self assert: res isNil.
	self assert: smscDatabase smsPending.

	res := smscDatabase findAndLockPendingSms: 'TestSystem' reject: #('someDest' 'someOtherDest').
	self deny: res isNil.
	self deny: smscDatabase smsPending.