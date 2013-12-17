Class {
	#name : #GTSUnitDebugSession,
	#superclass : #DebugSession,
	#instVars : [
		'assertionContext',
		'expectedResult',
		'actualResult'
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

{ #category : #'as yet unclassified' }
GTSUnitDebugSession >> isActive [

	^ self isActive: self testContext
]

{ #category : #'as yet unclassified' }
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
		expectedResult := assertionContext tempAt: 2]
]

{ #category : #accessing }
GTSUnitDebugSession >> testContext [

	^ assertionContext sender
]
