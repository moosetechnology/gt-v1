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
		'testContext',
		'assertionCallerContext'
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
GTSUnitDebugSession >> assertionCallerContext [

	^ assertionCallerContext
]

{ #category : #accessing }
GTSUnitDebugSession >> expectedResult [
	
	^ expectedResult 
]

{ #category : #initialization }
GTSUnitDebugSession >> initializeAssestionContextFrom: aContext [
	| frameworkTestClasses |
	
	frameworkTestClasses := {TestCase. TestCase superclass}.
	
	assertionContext := aContext findContextSuchThat: [ :anotherContext |
		anotherContext sender isNil or: [ 
			 (frameworkTestClasses anySatisfy: [ :aTestClass |
				 aTestClass includesSelector: anotherContext sender method selector]) not ] ].
	assertionContext 
		ifNil: [ assertionContext := aContext ]
		ifNotNil: [ assertionCallerContext := assertionContext sender].
	assertionCallerContext ifNil: [ assertionCallerContext := assertionContext ]
	
		
]

{ #category : #initialization }
GTSUnitDebugSession >> initializeTestContextFrom: aContext [

	testContext := aContext findContextSuchThat: [ :anotherContext |
		anotherContext method isTestMethod ].
	testContext ifNil: [ testContext := aContext ]
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
		self initializeAssestionContextFrom: aContext.
		self initializeTestContextFrom: assertionContext.
		self supportsDiff ifTrue: [ 
			actualResult := assertionContext tempAt: 1.
			expectedResult := assertionContext tempAt: 2 ]  ]
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

	^ testContext
]

{ #category : #accessing }
GTSUnitDebugSession >> testObject [

	^ testContext receiver
]
