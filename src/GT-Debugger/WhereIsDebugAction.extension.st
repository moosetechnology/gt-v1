Extension { #name : #WhereIsDebugAction }

{ #category : #'*GT-Debugger' }
WhereIsDebugAction class >> gtActionFor: aDebugger [
	<gtCodeDebuggingAction>
	
	^ (self forDebugger: aDebugger)
		action: #updateSelectionInterval
]
