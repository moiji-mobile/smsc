as yet unclassified
initialize
	super initialize.
	sem := Semaphore new.
	canceled := false.