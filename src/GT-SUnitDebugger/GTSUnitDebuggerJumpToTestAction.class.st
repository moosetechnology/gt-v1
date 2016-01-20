Class {
	#name : #GTSUnitDebuggerJumpToTestAction,
	#superclass : #DebugAction,
	#category : #'GT-SUnitDebugger'
}

{ #category : #'as yet unclassified' }
GTSUnitDebuggerJumpToTestAction class >> gtDebuggerActionFor: aDebugger [
	<gtStackDebuggingAction>
	
	^ (self forDebugger: aDebugger)
]

{ #category : #testing }
GTSUnitDebuggerJumpToTestAction >> appliesToDebugger: aDebugger [

	^ aDebugger session class = GTSUnitDebugSession and: [ 
		aDebugger session testContext ~= aDebugger session assertionCallerContext ]
]

{ #category : #accessing }
GTSUnitDebuggerJumpToTestAction >> defaultLabel [

	^ 'Jump to test method'
]

{ #category : #accessing }
GTSUnitDebuggerJumpToTestAction >> defaultOrder [

	^ 10
]

{ #category : #actions }
GTSUnitDebuggerJumpToTestAction >> executeAction [
	self debugger stackPresentation selection: self debugger session testContext
]

{ #category : #accessing }
GTSUnitDebuggerJumpToTestAction >> id [

	^ GTSUnitDebuggerJumpToTestAction name
]

{ #category : #'as yet unclassified' }
GTSUnitDebuggerJumpToTestAction >> initialize [
	super initialize.
	self needsUpdate: false
]
