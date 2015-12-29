Extension { #name : #Pharo3DarkTheme }

{ #category : #'*GT-Debugger' }
Pharo3DarkTheme >> styleContext: aContext from: aDebugger. [

	(aDebugger selectedContext == aContext) ifTrue: [ ^ {TextColor color: Smalltalk ui theme textColor}  ].

	(aContext receiver class = aDebugger selectedContext receiver class)
		ifTrue: [ ^ { TextColor cyan } ].
	(aContext receiver class package = aDebugger selectedContext receiver class package)
		ifTrue: [ ^ { TextColor magenta } ]. 

	^ {TextColor color: Color white}
]
