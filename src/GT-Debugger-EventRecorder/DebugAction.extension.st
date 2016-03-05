Extension { #name : #DebugAction }

{ #category : #'*GT-Debugger-EventRecorder' }
DebugAction >> asAboutToExecuteRecorderEvent [

	^ GTDebuggerDebugActionAboutToExecuteEvent new fromDebugAction: self
]

{ #category : #'*GT-Debugger-EventRecorder' }
DebugAction >> asExecutedRecorderEvent [

	^ GTDebuggerDebugActionExecutedEvent new fromDebugAction: self
]
