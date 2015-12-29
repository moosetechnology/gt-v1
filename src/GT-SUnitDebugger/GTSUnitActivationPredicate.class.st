Class {
	#name : #GTSUnitActivationPredicate,
	#superclass : #GTDebuggerContextPredicate,
	#category : #'GT-SUnitDebugger'
}

{ #category : #testing }
GTSUnitActivationPredicate >> matchContext: aContext [
	
	^ aContext selector == #assert:equals:
]
