Class {
	#name : #GTDebuggerDebugActionEvent,
	#superclass : #GTDebuggerRecorderEvent,
	#instVars : [
		'isExecuted'
	],
	#category : #'GT-Debugger-EventRecorder'
}

{ #category : #'instance creation' }
GTDebuggerDebugActionEvent class >> fromDebugAction: aDebugAction [

	^ self new fromDebugAction: aDebugAction
]

{ #category : #accessing }
GTDebuggerDebugActionEvent >> = otherGTDebuggerDebugActionEvent [
	(otherGTDebuggerDebugActionEvent isKindOf: self class) ifFalse: [ ^ false ].
	(self infoAt: #debugActionClass) == (otherGTDebuggerDebugActionEvent infoAt: #debugActionClass) ifFalse: [ ^ false ].
	(self infoAt: #methodClass) == (otherGTDebuggerDebugActionEvent infoAt: #methodClass) ifFalse: [ ^ false ].
	(self infoAt: #methodSelector) == (otherGTDebuggerDebugActionEvent infoAt: #methodSelector) ifFalse: [ ^ false ].
	(self infoAt: #pc) == (otherGTDebuggerDebugActionEvent infoAt: #pc) ifFalse: [ ^ false ].
	(self infoAt: #windowHash) == (otherGTDebuggerDebugActionEvent infoAt: #windowHash) ifFalse: [ ^ false ].
	^ true
]

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
	self infoAt: #methodClass putHashForText: aDebugAction currentContext methodClass name.
	self infoAt: #methodSelector putHashForText: aDebugAction currentContext methodSelector.
	self infoAt: #pc put: aDebugAction currentContext pc.
	self addWindowHashFor: aDebugAction debugger.
]

{ #category : #testing }
GTDebuggerDebugActionEvent >> isAboutToExectute [
	^ self isExecuted not
]

{ #category : #testing }
GTDebuggerDebugActionEvent >> isActionForClass: aClassName Method: aMethodName PC: anInteger [
	((self infoAt: #methodClass) == aClassName) ifFalse: [ ^ false ].
	((self infoAt: #methodSelector) == aMethodName) ifFalse: [ ^ false ].
	((self infoAt: #pc) == anInteger) ifFalse: [ ^ false ].
	^ true.
]

{ #category : #testing }
GTDebuggerDebugActionEvent >> isActionForContext: aContext [
	^ self isActionForClass: aContext methodClass name Method: aContext methodSelector PC: aContext pc.
]

{ #category : #testing }
GTDebuggerDebugActionEvent >> isExecuted [
	^ isExecuted
]

{ #category : #testing }
GTDebuggerDebugActionEvent >> isExecuted: aBoolean [
	isExecuted := aBoolean
]
