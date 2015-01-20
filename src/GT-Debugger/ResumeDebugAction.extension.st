Extension { #name : #ResumeDebugAction }

{ #category : #'*GT-Debugger' }
ResumeDebugAction class >> gtActionFor: aDebugger [
	<gtStackDebuggingAction>
	
	^ (self forDebugger: aDebugger)
			icon: GLMUIThemeExtraIcons glamorousPlay
]
