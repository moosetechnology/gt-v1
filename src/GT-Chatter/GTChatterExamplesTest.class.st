"
A GTChatterExamplesTest is a test class for testing the behavior of GTChatterExamples
"
Class {
	#name : #GTChatterExamplesTest,
	#superclass : #TestCase,
	#category : #'GT-Chatter-Tests'
}

{ #category : #accessing }
GTChatterExamplesTest >> examples [
	^ GTChatterExamples class selectors
			select: [ :symbol | symbol beginsWith: 'example' ]
]

{ #category : #examples }
GTChatterExamplesTest >> testExecuteExamples [
	self examples do: [ :eachSymbol | | result |
		result := (GTChatterExamples perform: eachSymbol).
		result delete. ]
]
