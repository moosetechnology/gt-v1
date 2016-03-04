Extension { #name : #DebugAction }

{ #category : #'*GT-Debugger-EventRecorder' }
DebugAction >> asRecorderEvent [

	^ GTDebuggerDebugActionEvent new fromDebugAction: self
]

{ #category : #'*GT-Debugger-EventRecorder' }
DebugAction >> changesContext [
	^ false
]
