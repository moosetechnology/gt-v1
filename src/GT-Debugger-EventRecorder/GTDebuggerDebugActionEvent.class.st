Class {
	#name : #GTDebuggerDebugActionEvent,
	#superclass : #GTDebuggerRecorderEvent,
	#category : #'GT-Debugger-EventRecorder'
}

{ #category : #accessing }
GTDebuggerDebugActionEvent >> asDebugActionFor: aDebugger [
	| actionClass |
	actionClass := (info at: #debugActionClass) asSymbol asClass.
	(actionClass respondsTo: #gtGlobalDebuggingActionFor:) ifTrue: [
		^ actionClass gtGlobalDebuggingActionFor: aDebugger ].
	^ nil
]

{ #category : #initialization }
GTDebuggerDebugActionEvent >> fromDebugAction: aDebugAction [
	self infoAt: #debugActionClass put: aDebugAction class name.
	self infoAt: #methodClass put: aDebugAction currentContext methodClass name.
	self infoAt: #methodSelector put: aDebugAction currentContext methodSelector.
	self infoAt: #pc put: aDebugAction currentContext pc.
	self addWindowHashFor: aDebugAction debugger.
]
