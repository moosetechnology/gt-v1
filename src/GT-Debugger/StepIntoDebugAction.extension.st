Extension { #name : #StepIntoDebugAction }

{ #category : #'*GT-Debugger' }
StepIntoDebugAction class >> gtActionFor: aDebugger [
	<gtDebuggingAction>
	<gtContextDebuggingAction>
	
	^ (self forDebugger: aDebugger)
			icon: GLMUIThemeExtraIcons glamorousInto
]
