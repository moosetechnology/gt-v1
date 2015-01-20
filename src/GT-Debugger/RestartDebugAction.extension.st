Extension { #name : #RestartDebugAction }

{ #category : #'*GT-Debugger' }
RestartDebugAction class >> gtActionFor: aDebugger [
	<gtDebuggingAction>
	
	^ (self forDebugger: aDebugger)
			icon: GLMUIThemeExtraIcons glamorousRestart
]
