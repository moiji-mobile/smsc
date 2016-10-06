as yet unclassified
initialize
	super initialize.
	notifiers := OrderedCollection new.
	sem := Semaphore forMutualExclusion.
	quit := false.