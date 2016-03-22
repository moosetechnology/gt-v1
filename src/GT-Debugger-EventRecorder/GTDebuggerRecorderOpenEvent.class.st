"
I model the action of opening the debugger.
"
Class {
	#name : #GTDebuggerRecorderOpenEvent,
	#superclass : #GTDebuggerRecorderEvent,
	#category : #'GT-Debugger-EventRecorder-Events'
}

{ #category : #'instance creation' }
GTDebuggerRecorderOpenEvent class >> fromDebugger: aDebugger [

	^ self new fromDebugger: aDebugger
]

{ #category : #accessing }
GTDebuggerRecorderOpenEvent >> addTitleFor: aDebugger [
	(Privacy sendEntityNames or: [ self isTitleAKernelException: aDebugger title ]) ifTrue: [ self infoAt: #title put: aDebugger title ].
]

{ #category : #initialization }
GTDebuggerRecorderOpenEvent >> fromDebugger: aDebugger [

	self infoAt: #debuggerClass put: aDebugger class name.
	self addWindowHashFor: aDebugger.
	self addTitleFor: aDebugger.
]

{ #category : #initialization }
GTDebuggerRecorderOpenEvent >> initialize [
	super initialize.
	self initializeObfuscated.
]

{ #category : #private }
GTDebuggerRecorderOpenEvent >> isTitleAKernelException: aString [
	^ (#Kernel asPackage classTagNamed: #Exceptions) classes anySatisfy: [ :e | e name = aString asSymbol ]
]
