as yet unclassified
run
	runProc := [
		[
			[quit]
				whileFalse: [self queryOnce]
		] ensure: [root close]] newProcess.
	runProc name: 'ShortMessageNotifier'.
	runProc resume.