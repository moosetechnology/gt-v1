Class {
	#name : #GTInspectorSetTest,
	#superclass : #GTInspectorSmokeTest,
	#category : #'GT-Tests-Inspector'
}

{ #category : #tests }
GTInspectorSetTest >> objectToTest [ 
	^ #('number' 42) asSet
]
