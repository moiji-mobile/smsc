*ShortMessageCenter-Delivery
smscDiscardAllAndTerminate
	localInvocations do: [:each | each cancelTimer ].
	self terminate.