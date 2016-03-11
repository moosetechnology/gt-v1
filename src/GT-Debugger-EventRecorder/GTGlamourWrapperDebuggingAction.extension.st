Extension { #name : #GTGlamourWrapperDebuggingAction }

{ #category : #'*GT-Debugger-EventRecorder' }
GTGlamourWrapperDebuggingAction >> asRecorderEvent [

	^ GTGlamourWrapperDebuggingActionEvent new fromDebugAction: self
]
