Extension { #name : #ChangeDebuggerAction }

{ #category : #'*GT-Debugger' }
ChangeDebuggerAction classSide >> gtChangeDebuggerActionsFor: aDebugger [
	<gtDebuggingAction>
	
	^ self 
		changeDebuggerActionsForContext: aDebugger interruptedContext 
		excluding: aDebugger
]
