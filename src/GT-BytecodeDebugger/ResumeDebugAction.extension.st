Extension { #name : #ResumeDebugAction }

{ #category : #'*GT-BytecodeDebugger' }
ResumeDebugAction class >> gtBytecodeDebuggerActionFor: aDebugger [
	<gtBytecodeStackDebuggingAction>
	
	^ (self forDebugger: aDebugger)
			icon: GLMUIThemeExtraIcons glamorousPlay
]
