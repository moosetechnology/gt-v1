Class {
	#name : #GTSUnitDebugSession,
	#superclass : #DebugSession,
	#instVars : [
		'assertionContext'
	],
	#category : #'GT-SUnitDebugger'
}

{ #category : #'as yet unclassified' }
GTSUnitDebugSession class >> activationPredicate [

	^  GTSUnitActivationPredicate new
]

{ #category : #'as yet unclassified' }
GTSUnitDebugSession >> actualResult [
	
	^ assertionContext tempAt: 1
]

{ #category : #'as yet unclassified' }
GTSUnitDebugSession >> expectedResult [
	
	^ assertionContext tempAt: 2
]

{ #category : #'as yet unclassified' }
GTSUnitDebugSession >> process: aProcess context: aContext [

	super process: aProcess context: aContext.
	
	assertionContext ifNil: [
		assertionContext := aContext findContextMatchingPredicate: self class activationPredicate]
]

{ #category : #'as yet unclassified' }
GTSUnitDebugSession >> testContext [

	^ assertionContext sender
]
