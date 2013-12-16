Extension { #name : #RestartDebugAction }

{ #category : #'*GT-Debugger' }
RestartDebugAction class >> gtActionFor: aDebugger [
	<gtDebuggingAction>
	<gtContextDebuggingAction>
	
	^ (self forDebugger: aDebugger)
			icon: GLMUIThemeExtraIcons glamorousRestart
]
