Extension { #name : #GTCodeDebugAction }

{ #category : #'*GT-Debugger-EventRecorder' }
GTCodeDebugAction >> asRecorderEvent [

	^ GTCodeDebugActionEvent fromDebugAction: self
]
