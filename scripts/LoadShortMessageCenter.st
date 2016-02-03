Author useAuthor: 'Builder' during: [ 
	Gofer new
		url: 'filetree://./mc';
		package: 'ConfigurationOfShortMessageCenter';
		load.	
	(Smalltalk at: #ConfigurationOfShortMessageCenter) loadDevelopment ].

(Smalltalk saveAs: 'ShortMessageCenter') 
    ifFalse: [ Smalltalk snapshot: false andQuit: true ].

