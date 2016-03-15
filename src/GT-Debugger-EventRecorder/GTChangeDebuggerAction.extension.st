Extension { #name : #GTChangeDebuggerAction }

{ #category : #'*GT-Debugger-EventRecorder' }
GTChangeDebuggerAction >> asRecorderEvent [

	^ GTDebuggerChangeDebuggerEvent fromDebugAction: self
]
