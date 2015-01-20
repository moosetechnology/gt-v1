Extension { #name : #DoesNotUnderstandDebugAction }

{ #category : #'*GT-Debugger' }
DoesNotUnderstandDebugAction class >> gtActionFor: aDebugger [
	<gtDebuggingAction>
	
	^ (self forDebugger: aDebugger)
			icon: GLMUIThemeExtraIcons glamorousAdd
]
