Extension { #name : #MessageSendDebugAction }

{ #category : #'*GT-Debugger-EventRecorder' }
MessageSendDebugAction >> asRecorderEvent [

	^ MessageSendDebugActionEvent fromDebugAction: self
]
