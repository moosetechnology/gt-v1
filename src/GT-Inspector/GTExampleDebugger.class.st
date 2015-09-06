Class {
	#name : #GTExampleDebugger,
	#superclass : #GTExampleEvaluator,
	#category : #'GT-Inspector-Example-Tools'
}

{ #category : #private }
GTExampleDebugger >> do: aBlock on: anException do: anotherBlock [
	aBlock value
]
