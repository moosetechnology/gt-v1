Extension { #name : #GTChangeDebuggerAction }

{ #category : #'*GT-Debugger-EventRecorder' }
GTChangeDebuggerAction >> asExecutedRecorderEvent [

	^ GTDebuggerChangeDebuggerExecutedEvent new fromDebugAction: self
]
