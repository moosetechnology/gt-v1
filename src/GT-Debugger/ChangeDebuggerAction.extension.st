Extension { #name : #ChangeDebuggerAction }

{ #category : #'*GT-Debugger' }
ChangeDebuggerAction classSide >> gtChangeDebuggerActionsFor: aDebugger [
	<gtStackDebuggingAction>
	
	^ self 
		changeDebuggerActionsForContext: aDebugger interruptedContext 
		excluding: aDebugger
]
