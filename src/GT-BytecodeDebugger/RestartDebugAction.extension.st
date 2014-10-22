Extension { #name : #RestartDebugAction }

{ #category : #'*GT-BytecodeDebugger' }
RestartDebugAction class >> gtBytecodeDebuggerActionFor: aDebugger [
	<gtBytecodeStackDebuggingAction>
	
	^ (self forDebugger: aDebugger)
			icon: GLMUIThemeExtraIcons glamorousRestart
]
