Extension { #name : #CopyToClipboardDebugAction }

{ #category : #'*GT-BytecodeDebugger' }
CopyToClipboardDebugAction class >> gtBytecodeDebuggerActionFor: aDebugger [
	<gtBytecodeStackDebuggingAction>
	
	^ (self forDebugger: aDebugger)
			order: 35
]
