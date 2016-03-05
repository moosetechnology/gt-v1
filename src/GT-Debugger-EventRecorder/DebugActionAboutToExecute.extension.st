Extension { #name : #DebugActionAboutToExecute }

{ #category : #'*GT-Debugger-EventRecorder' }
DebugActionAboutToExecute >> asRecorderEvent [

	^ (debuggingAction asAboutToExecuteRecorderEvent fromAnnouncement: self)
]
