Class {
	#name : #GTSUnitDebugSession,
	#superclass : #DebugSession,
	#instVars : [
		'assertionContext'
	],
	#category : #'GT-SUnitDebugger'
}

{ #category : #accessing }
GTSUnitDebugSession class >> activationPredicate [

	^  GTSUnitActivationPredicate new
]

{ #category : #accessing }
GTSUnitDebugSession >> actualResult [
	
	^ assertionContext tempAt: 1
]

{ #category : #accessing }
GTSUnitDebugSession >> expectedResult [
	
	^ assertionContext tempAt: 2
]

{ #category : #initialization }
GTSUnitDebugSession >> process: aProcess context: aContext [

	super process: aProcess context: aContext.
	
	assertionContext ifNil: [
		assertionContext := aContext findContextMatchingPredicate: self class activationPredicate]
]

{ #category : #accessing }
GTSUnitDebugSession >> testContext [

	^ assertionContext sender
]
