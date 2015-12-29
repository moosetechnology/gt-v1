Extension { #name : #UITheme }

{ #category : #'*GT-Debugger' }
UITheme >> styleContext: aContext from: aDebugger. [

	(aDebugger selectedContext == aContext) ifTrue: [ ^ {TextColor color: Smalltalk ui theme textColor}  ].

	(aContext receiver class = aDebugger selectedContext receiver class)
		ifTrue: [ ^ { TextColor blue } ].
	(aContext receiver class package = aDebugger selectedContext receiver class package)
		ifTrue: [ ^ { TextColor black } ]. 

	^ {TextColor gray}
]
