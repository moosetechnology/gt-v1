Class {
	#name : #GTDebuggerDebugActionEvent,
	#superclass : #GTDebuggerRecorderEvent,
	#category : #'GT-Debugger-EventRecorder'
}

{ #category : #accessing }
GTDebuggerDebugActionEvent >> = otherGTDebuggerDebugActionEvent [
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
	self infoAt: #methodClass put: aDebugAction currentContext methodClass name.
	self infoAt: #methodSelector put: aDebugAction currentContext methodSelector.
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
	self subclassResponsibility
]
