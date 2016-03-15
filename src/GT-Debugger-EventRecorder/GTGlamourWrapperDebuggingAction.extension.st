Extension { #name : #GTGlamourWrapperDebuggingAction }

{ #category : #'*GT-Debugger-EventRecorder' }
GTGlamourWrapperDebuggingAction >> asRecorderEvent [

	^ GTGlamourWrapperDebuggingActionEvent fromDebugAction: self
]
