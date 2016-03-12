Extension { #name : #GTGoAndInspectBytecodeDebugAction }

{ #category : #'*GT-Debugger-EventRecorder' }
GTGoAndInspectBytecodeDebugAction >> asRecorderEvent [

	^ GTGoAndInspectBytecodeDebugActionEvent new fromDebugAction: self
]
