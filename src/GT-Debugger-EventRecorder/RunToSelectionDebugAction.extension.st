Extension { #name : #RunToSelectionDebugAction }

{ #category : #'*GT-Debugger-EventRecorder' }
RunToSelectionDebugAction >> asRecorderEvent [

	^ RunToSelectionDebugActionEvent fromDebugAction: self
]
