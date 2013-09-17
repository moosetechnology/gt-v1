Extension { #name : #RunToHereDebugAction }

{ #category : #'*GT-Debugger' }
RunToHereDebugAction classSide >> defaultIcon [

	^ GLMUIThemeExtraIcons glamorousPlay
]

{ #category : #'*GT-Debugger' }
RunToHereDebugAction classSide >> gtActionFor: aDebugger [
	<gtCodeDebuggingAction>
	
	^ (self forDebugger: aDebugger)
		arguments: [ :action | { action debugger selectionInterval. action currentContext } ].
]
