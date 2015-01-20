Extension { #name : #DoesNotUnderstandDebugAction }

{ #category : #'*GT-Debugger' }
DoesNotUnderstandDebugAction class >> gtActionFor: aDebugger [
	<gtStackDebuggingAction>
	
	^ (self forDebugger: aDebugger)
			icon: GLMUIThemeExtraIcons glamorousAdd
]
