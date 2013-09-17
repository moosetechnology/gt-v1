Extension { #name : #SaveDebugAction }

{ #category : #'*GT-Debugger' }
SaveDebugAction >> asGlamourAction [

	^ super asGlamourAction
			action: [ :textPresentation | 
				self sourceCode: textPresentation text.
				self execute ]
]

{ #category : #'*GT-Debugger' }
SaveDebugAction classSide >> defaultIcon [

	^ GLMUIThemeExtraIcons glamorousAccept
]

{ #category : #'*GT-Debugger' }
SaveDebugAction classSide >> gtActionType [
	<gtCodeDebuggingAction>
]
