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
		actualResult := assertionContext tempAt: 1.
		expectedResult := assertionContext tempAt: 2.
		testObject := assertionContext sender receiver ]
]

{ #category : #accessing }
GTSUnitDebugSession >> setUpMethod [

	^ self testObject class lookupSelector: #setUp
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
