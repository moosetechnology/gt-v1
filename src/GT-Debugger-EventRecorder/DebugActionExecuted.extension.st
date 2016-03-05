Extension { #name : #DebugActionExecuted }

{ #category : #'*GT-Debugger-EventRecorder' }
DebugActionExecuted >> asRecorderEvent [

	^ (debuggingAction asExecutedRecorderEvent fromAnnouncement: self)
]
