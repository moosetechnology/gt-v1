Extension { #name : #StepOverDebugAction }

{ #category : #'*GT-Debugger' }
StepOverDebugAction class >> gtActionFor: aDebugger [
	<gtDebuggingAction>
	<gtContextDebuggingAction>
	
	^ (self forDebugger: aDebugger)
			icon: GLMUIThemeExtraIcons glamorousOver
]
