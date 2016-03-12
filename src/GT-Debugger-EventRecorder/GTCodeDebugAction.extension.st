Extension { #name : #GTCodeDebugAction }

{ #category : #'*GT-Debugger-EventRecorder' }
GTCodeDebugAction >> asRecorderEvent [

	^ GTCodeDebugActionEvent new fromDebugAction: self
]
