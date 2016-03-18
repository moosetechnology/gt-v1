Extension { #name : #GTChangeDebuggerAction }

{ #category : #'*GT-Debugger-EventRecorder' }
GTChangeDebuggerAction >> asRecorderEvent [

	^ GTDebuggerRecorderChangeDebuggerEvent fromDebugAction: self
]
