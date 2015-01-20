Extension { #name : #RestartDebugAction }

{ #category : #'*GT-Debugger' }
RestartDebugAction class >> gtActionFor: aDebugger [
	<gtStackDebuggingAction>
	
	^ (self forDebugger: aDebugger)
			icon: GLMUIThemeExtraIcons glamorousRestart
]
