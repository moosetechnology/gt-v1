Class {
	#name : #GTExampleDebugger,
	#superclass : #GTExampleEvaluator,
	#category : #'GT-Inspector-Examples-Tools'
}

{ #category : #private }
GTExampleDebugger >> do: aBlock on: anException do: anotherBlock [
	aBlock value
]
