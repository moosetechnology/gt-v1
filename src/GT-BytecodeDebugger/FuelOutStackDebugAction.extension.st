Extension { #name : #FuelOutStackDebugAction }

{ #category : #'*GT-BytecodeDebugger' }
FuelOutStackDebugAction class >> gtBytecodeDebuggerActionFor: aDebugger [
	<gtBytecodeStackDebuggingAction>
	
	^ (self forDebugger: aDebugger)
			order: 30
]
