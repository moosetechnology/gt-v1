Extension { #name : #StepThroughDebugAction }

{ #category : #'*GT-Debugger' }
StepThroughDebugAction class >> gtActionFor: aDebugger [
	<gtDebuggingAction>
	
	^ (self forDebugger: aDebugger)
			icon: GLMUIThemeExtraIcons glamorousThrough
]
