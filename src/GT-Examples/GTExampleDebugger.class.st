"
I am an example processor that evaluates the examples in a debugging scenario as if they are tests and I cache the result.
In case of an error, I do not intervene, and thus I allow the user to intervene through the debugger.
"
Class {
	#name : #GTExampleDebugger,
	#superclass : #GTExampleEvaluator,
	#category : #'GT-Examples-Runtime'
}

{ #category : #private }
GTExampleDebugger >> do: aBlock on: anException do: anotherBlock [
	aBlock value
]
