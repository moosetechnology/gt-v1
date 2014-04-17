Extension { #name : #StepOverDebugAction }

{ #category : #'*GT-Debugger' }
StepOverDebugAction class >> gtActionFor: aDebugger [
	<gtDebuggingAction>
	
	^ (self forDebugger: aDebugger)
			icon: GLMUIThemeExtraIcons glamorousOver
]
