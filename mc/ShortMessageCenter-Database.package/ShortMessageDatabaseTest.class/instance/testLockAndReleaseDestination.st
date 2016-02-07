tests-polling
testLockAndReleaseDestination
	|  res |

	"No destination is locked yet..."
	self assert: smscDatabase collectionForLock size equals: 0.
	smscDatabase lockDestination: '4234242314' for: 'testcase'.
	smscDatabase lockDestination: '4234242315' for: 'testcase'.
	self assert: smscDatabase collectionForLock size equals: 2.
	res := smscDatabase releaseDestination: '4234242314'.
	self deny: res isNil.
	self assert: smscDatabase collectionForLock size equals: 1.
	res := smscDatabase releaseDestination: '4234242315'.
	self deny: res isNil.
	self assert: smscDatabase collectionForLock size equals: 0.

	"Double lock"
	res := smscDatabase lockDestination: '4234242314' for: 'testcase'.
	self deny: res isNil.
	res := smscDatabase lockDestination: '4234242314' for: 'testcase'.
	self assert: res isNil.