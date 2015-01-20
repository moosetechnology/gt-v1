Extension { #name : #StepIntoDebugAction }

{ #category : #'*GT-Debugger' }
StepIntoDebugAction class >> gtActionFor: aDebugger [
	<gtStackDebuggingAction>
	
	^ (self forDebugger: aDebugger)
			icon: GLMUIThemeExtraIcons glamorousInto
]
