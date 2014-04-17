Extension { #name : #FuelOutStackDebugAction }

{ #category : #'*GT-Debugger-Actions' }
FuelOutStackDebugAction class >> gtActionFor: aDebugger [
	<gtDebuggingAction>
	
	^ (self forDebugger: aDebugger)
			order: 30
]
