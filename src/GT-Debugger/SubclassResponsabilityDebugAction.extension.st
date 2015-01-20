Extension { #name : #SubclassResponsabilityDebugAction }

{ #category : #'*GT-Debugger' }
SubclassResponsabilityDebugAction class >> gtActionFor: aDebugger [
	<gtStackDebuggingAction>
	
	^ (self forDebugger: aDebugger)
			icon: GLMUIThemeExtraIcons glamorousAdd
]
