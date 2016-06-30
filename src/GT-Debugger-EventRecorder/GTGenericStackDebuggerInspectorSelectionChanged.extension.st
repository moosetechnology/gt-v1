Extension { #name : #GTGenericStackDebuggerInspectorSelectionChanged }

{ #category : #'*GT-Debugger-EventRecorder' }
GTGenericStackDebuggerInspectorSelectionChanged >> asRecorderEvent [

	^ GTDebuggerRecorderInspectorSelectionChangedEvent fromAnnouncement: self
]
