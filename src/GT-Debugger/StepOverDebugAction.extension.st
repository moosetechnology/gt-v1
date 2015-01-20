Extension { #name : #StepOverDebugAction }

{ #category : #'*GT-Debugger' }
StepOverDebugAction class >> gtActionFor: aDebugger [
	<gtStackDebuggingAction>
	
	^ (self forDebugger: aDebugger)
			icon: GLMUIThemeExtraIcons glamorousOver
]
