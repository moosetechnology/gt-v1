Extension { #name : #SubclassResponsabilityDebugAction }

{ #category : #'*GT-Debugger' }
SubclassResponsabilityDebugAction class >> gtActionFor: aDebugger [
	<gtDebuggingAction>
	
	^ (self forDebugger: aDebugger)
			icon: GLMUIThemeExtraIcons glamorousAdd
]
