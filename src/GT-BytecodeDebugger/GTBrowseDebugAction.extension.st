Extension { #name : #GTBrowseDebugAction }

{ #category : #'*GT-BytecodeDebugger' }
GTBrowseDebugAction class >> gtBytecodeDebuggerActionFor: aDebugger [
	<gtContextBytecodeStackDebuggingAction>
	
	^ super debugActionsFor: aDebugger
]
