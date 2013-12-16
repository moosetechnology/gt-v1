Extension { #name : #ResumeDebugAction }

{ #category : #'*GT-Debugger' }
ResumeDebugAction class >> gtActionFor: aDebugger [
	<gtDebuggingAction>
	<gtContextDebuggingAction>
	
	^ (self forDebugger: aDebugger)
			icon: GLMUIThemeExtraIcons glamorousPlay
]
