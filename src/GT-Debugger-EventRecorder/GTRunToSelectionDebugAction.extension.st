Extension { #name : #GTRunToSelectionDebugAction }

{ #category : #'*GT-Debugger-EventRecorder' }
GTRunToSelectionDebugAction >> asRecorderEvent [

	^ GTRunToSelectionDebugActionEvent new fromDebugAction: self
]
