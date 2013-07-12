Extension { #name : #RunToHereDebugAction }

{ #category : #'*GT-Debugger' }
RunToHereDebugAction classSide >> gtActionType [
	<gtCodeDebuggingAction>
	
	^ self new
		arguments: [ :action | { action debugger selectionInterval. action currentContext } ].
]
