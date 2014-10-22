Extension { #name : #ChangeDebuggerAction }

{ #category : #'*GT-BytecodeDebugger' }
ChangeDebuggerAction classSide >> gtBytecodeDebuggerActionFor: aDebugger [
	<gtBytecodeStackDebuggingAction>
	
	^ self gtChangeDebuggerActionsFor: aDebugger
]
