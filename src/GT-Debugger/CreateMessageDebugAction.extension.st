Extension { #name : #CreateMessageDebugAction }

{ #category : #'*GT-Debugger' }
CreateMessageDebugAction classSide >> gtActionFor: aDebugger [
	<gtContextDebuggingAction>
	
	^ (self forDebugger: aDebugger)
		icon: GLMUIThemeExtraIcons glamorousAdd
]
