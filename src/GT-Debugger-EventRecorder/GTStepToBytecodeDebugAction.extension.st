Extension { #name : #GTStepToBytecodeDebugAction }

{ #category : #'*GT-Debugger-EventRecorder' }
GTStepToBytecodeDebugAction >> asRecorderEvent [

	^ GTStepToBytecodeDebugActionEvent fromDebugAction: self
]
