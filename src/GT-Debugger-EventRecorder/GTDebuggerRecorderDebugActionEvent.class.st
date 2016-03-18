"
I model the debugging actions in the debugger.
"
Class {
	#name : #GTDebuggerRecorderDebugActionEvent,
	#superclass : #GTDebuggerRecorderEvent,
	#instVars : [
		'isExecuted'
	],
	#category : #'GT-Debugger-EventRecorder-Events'
}

{ #category : #'instance creation' }
GTDebuggerRecorderDebugActionEvent class >> fromDebugAction: aDebugAction [

	^ self new fromDebugAction: aDebugAction
]

{ #category : #accessing }
GTDebuggerRecorderDebugActionEvent >> asDebugActionFor: aDebugger [
	| actionClass |
	actionClass := (info at: #debugActionClass) asSymbol asClass.
	(actionClass respondsTo: #gtGlobalDebuggingActionFor:) ifTrue: [
		^ actionClass gtGlobalDebuggingActionFor: aDebugger ].
	^ nil
]

{ #category : #initialization }
GTDebuggerRecorderDebugActionEvent >> fromDebugAction: aDebugAction [
	self infoAt: #debugActionClass put: aDebugAction class name.
	self infoAt: #methodClass putHashForText: aDebugAction currentContext methodClass name.
	self infoAt: #methodSelector putHashForText: aDebugAction currentContext methodSelector.
	self infoAt: #pc put: aDebugAction currentContext pc.
	self addWindowHashFor: aDebugAction debugger.
]

{ #category : #testing }
GTDebuggerRecorderDebugActionEvent >> isAboutToExectute [
	^ self isExecuted not
]

{ #category : #testing }
GTDebuggerRecorderDebugActionEvent >> isActionForClass: aClassName Method: aMethodName PC: anInteger [
	((self infoAt: #methodClass) == aClassName) ifFalse: [ ^ false ].
	((self infoAt: #methodSelector) == aMethodName) ifFalse: [ ^ false ].
	((self infoAt: #pc) == anInteger) ifFalse: [ ^ false ].
	^ true.
]

{ #category : #testing }
GTDebuggerRecorderDebugActionEvent >> isActionForContext: aContext [
	^ self isActionForClass: aContext methodClass name Method: aContext methodSelector PC: aContext pc.
]

{ #category : #testing }
GTDebuggerRecorderDebugActionEvent >> isExecuted [
	^ isExecuted
]

{ #category : #testing }
GTDebuggerRecorderDebugActionEvent >> isExecuted: aBoolean [
	isExecuted := aBoolean
]
