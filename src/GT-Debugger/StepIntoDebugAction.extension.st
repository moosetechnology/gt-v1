Extension { #name : #StepIntoDebugAction }

{ #category : #'*GT-Debugger' }
StepIntoDebugAction class >> gtActionFor: aDebugger [
	<gtDebuggingAction>
	
	^ (self forDebugger: aDebugger)
			icon: GLMUIThemeExtraIcons glamorousInto
]
