Extension { #name : #StepThroughDebugAction }

{ #category : #'*GT-Debugger' }
StepThroughDebugAction class >> gtActionFor: aDebugger [
	<gtStackDebuggingAction>
	
	^ (self forDebugger: aDebugger)
			icon: GLMUIThemeExtraIcons glamorousThrough
]
