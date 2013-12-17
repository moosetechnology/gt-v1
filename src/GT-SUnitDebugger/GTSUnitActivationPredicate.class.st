Class {
	#name : #GTSUnitActivationPredicate,
	#superclass : #ContextPredicate,
	#category : #'GT-SUnitDebugger'
}

{ #category : #testing }
GTSUnitActivationPredicate >> matchContext: aContext [
	
	^ aContext selector == #assert:equals:
]
