Extension { #name : #ChangeDebuggerAction }

{ #category : #'*GT-Debugger' }
ChangeDebuggerAction classSide >> gtChangeDebuggerActionsFor: aDebugger [
	<gtContextDebuggingAction>
	
	^ self 
		changeDebuggerActionsForContext: aDebugger currentContext 
		excluding: aDebugger
]
