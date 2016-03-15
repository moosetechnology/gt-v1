Extension { #name : #GTGenericStackDebuggerSelectionChanged }

{ #category : #'*GT-Debugger-EventRecorder' }
GTGenericStackDebuggerSelectionChanged >> asRecorderEvent [

	^ GTGenericStackDebuggerSelectionChangedEvent fromAnnouncement: self
]
