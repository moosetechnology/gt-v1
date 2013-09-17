Extension { #name : #ResumeDebugAction }

{ #category : #'*GT-Debugger' }
ResumeDebugAction class >> gtActionFor: aDebugger [
	<gtDebuggingAction>
	
	^ (self forDebugger: aDebugger)
		icon: GLMUIThemeExtraIcons glamorousPlay
]
