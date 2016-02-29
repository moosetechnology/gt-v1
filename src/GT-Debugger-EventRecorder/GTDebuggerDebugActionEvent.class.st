Class {
	#name : #GTDebuggerDebugActionEvent,
	#superclass : #GTDebuggerRecorderEvent,
	#category : #'GT-Debugger-EventRecorder'
}

{ #category : #initialization }
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
	"self addWindowHashFor: aDebugAction debugger"
	
]
