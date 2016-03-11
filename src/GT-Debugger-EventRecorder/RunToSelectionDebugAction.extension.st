Extension { #name : #RunToSelectionDebugAction }

{ #category : #'*GT-Debugger-EventRecorder' }
RunToSelectionDebugAction >> asRecorderEvent [

	^ RunToSelectionDebugActionEvent new fromDebugAction: self
]
