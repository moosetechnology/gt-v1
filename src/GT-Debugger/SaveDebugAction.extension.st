Extension { #name : #SaveDebugAction }

{ #category : #'*GT-Debugger' }
SaveDebugAction >> asGlamourAction [

	^ super asGlamourAction
			action: [ :textPresentation | 
				self sourceCode: textPresentation text.
				self execute ]
]
