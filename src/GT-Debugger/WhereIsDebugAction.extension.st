Extension { #name : #WhereIsDebugAction }

{ #category : #'*GT-Debugger' }
WhereIsDebugAction class >> gtActionFor: aDebugger [
	<gtCodeDebuggingAction>
	
	^ self new
		action: #updateSelectionInterval
]
