Extension { #name : #GTRunToSelectionDebugAction }

{ #category : #'*GT-Debugger-EventRecorder' }
GTRunToSelectionDebugAction >> asRecorderEvent [

	^ GTRunToSelectionDebugActionEvent fromDebugAction: self
]
