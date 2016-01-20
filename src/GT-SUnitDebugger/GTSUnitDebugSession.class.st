"
I am a debugging session for the SUnit debugger. 
I extract from the execution stack various data needed by the user interface of the SUnit debugger, like the test object and method.

Public API and Key Messages

- process:context: does the initialization of the session
- data is provided using the methods in the accessing protocol

    Instance Variables
	actualResult:		<Object>
	assertionContext:		<Object>
	expectedResult:		<Object>
	testObject:		<Object>
"
Class {
	#name : #GTSUnitDebugSession,
	#superclass : #DebugSession,
	#instVars : [
		'assertionContext',
		'expectedResult',
		'actualResult',
		'testObject'
	],
	#category : #'GT-SUnitDebugger'
}

{ #category : #accessing }
GTSUnitDebugSession class >> activationPredicate [

	^  GTSUnitActivationPredicate new
]

{ #category : #accessing }
GTSUnitDebugSession >> actualResult [
	
	^ actualResult
]

{ #category : #accessing }
GTSUnitDebugSession >> expectedResult [
	
	^ expectedResult 
]

{ #category : #testing }
GTSUnitDebugSession >> isActive [

	^ self isActive: self testContext
]

{ #category : #testing }
GTSUnitDebugSession >> isActive: aContext [

	^ aContext 
		ifNil: [ false ] 
		ifNotNil: [ 
			aContext isDead not and: [
				aContext ~= self process suspendedContext or: [aContext willReturn not ] ] ]
]

{ #category : #initialization }
GTSUnitDebugSession >> process: aProcess context: aContext [

	super process: aProcess context: aContext.

	assertionContext ifNil: [
		assertionContext := aContext findContextMatchingPredicate: self class activationPredicate.
		self supportsDiff ifTrue: [ 
			actualResult := assertionContext tempAt: 1.
			expectedResult := assertionContext tempAt: 2 ].
		testObject := assertionContext sender receiver ]
]

{ #category : #accessing }
GTSUnitDebugSession >> setUpMethod [

	^ self testObject class lookupSelector: #setUp
]

{ #category : #testing }
GTSUnitDebugSession >> supportsDiff [

	^ assertionContext selector = #assert:equals:
]

{ #category : #accessing }
GTSUnitDebugSession >> tearDownMethod [

	^ self testObject class lookupSelector: #tearDown
]

{ #category : #accessing }
GTSUnitDebugSession >> testContext [

	^ assertionContext sender
]

{ #category : #accessing }
GTSUnitDebugSession >> testObject [

	^ testObject
]
