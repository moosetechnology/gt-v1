Extension { #name : #DebugAction }

{ #category : #'*GT-Debugger-EventRecorder' }
DebugAction >> asRecorderEvent [

	^ GTDebuggerDebugActionEvent fromDebugAction: self
]
