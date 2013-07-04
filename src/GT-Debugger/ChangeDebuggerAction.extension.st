Extension { #name : #ChangeDebuggerAction }

{ #category : #'*GT-Debugger' }
ChangeDebuggerAction classSide >> gtChangeDebuggerActionsFor: aDebugger [
	<gtContextDebuggingAction>
	
	^ (aDebugger debuggersForContext: aDebugger selectedContext) collect: [ :aDebuggerClass | 
		self new
			debuggerClass: aDebuggerClass ]
]
