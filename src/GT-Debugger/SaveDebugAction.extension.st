Extension { #name : #SaveDebugAction }

{ #category : #'*GT-Debugger' }
SaveDebugAction >> asGlamourAction [

	^ super asGlamourAction
			action: [ :textPresentation | 
				self sourceCode: textPresentation text.
				self execute ]
]

{ #category : #'*GT-Debugger' }
SaveDebugAction classSide >> gtActionFor: aDebugger [
	<gtCodeDebuggingAction>
	
	^ (self forDebugger: aDebugger)
			icon: GLMUIThemeExtraIcons glamorousAccept
]
