Class {
	#name : #GTSUnitActivationPredicate,
	#superclass : #ContextPredicate,
	#category : #'GT-SUnitDebugger'
}

{ #category : #'as yet unclassified' }
GTSUnitActivationPredicate >> matchContext: aContext [
	
	^ aContext selector == #assert:equals:
]
