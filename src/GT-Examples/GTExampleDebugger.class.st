Class {
	#name : #GTExampleDebugger,
	#superclass : #GTExampleEvaluator,
	#category : #'GT-Examples-Tools'
}

{ #category : #private }
GTExampleDebugger >> do: aBlock on: anException do: anotherBlock [
	aBlock value
]