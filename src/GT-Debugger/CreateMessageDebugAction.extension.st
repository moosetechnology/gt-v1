Extension { #name : #CreateMessageDebugAction }

{ #category : #'*GT-Debugger' }
CreateMessageDebugAction classSide >> defaultIcon [

	^ GLMUIThemeExtraIcons glamorousAdd
]

{ #category : #'*GT-Debugger' }
CreateMessageDebugAction classSide >> gtActionType [
	<gtContextDebuggingAction>
]
