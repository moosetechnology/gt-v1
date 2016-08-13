Class {
	#name : #GTExampleDebugger,
	#superclass : #GTExampleEvaluator,
	#category : #'GT-Examples-Runtime'
}

{ #category : #private }
GTExampleDebugger >> do: aBlock on: anException do: anotherBlock [
	aBlock value
]
