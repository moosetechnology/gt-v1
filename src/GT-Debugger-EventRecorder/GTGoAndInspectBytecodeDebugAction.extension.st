Extension { #name : #GTGoAndInspectBytecodeDebugAction }

{ #category : #'*GT-Debugger-EventRecorder' }
GTGoAndInspectBytecodeDebugAction >> asRecorderEvent [

	^ GTGoAndInspectBytecodeDebugActionEvent fromDebugAction: self
]
