Extension { #name : #StepThroughDebugAction }

{ #category : #'*GT-Debugger' }
StepThroughDebugAction class >> gtActionFor: aDebugger [
	<gtDebuggingAction>
	<gtContextDebuggingAction>
	
	^ (self forDebugger: aDebugger)
			icon: GLMUIThemeExtraIcons glamorousThrough
]
