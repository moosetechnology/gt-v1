Class {
	#name : #GTFailingTest,
	#superclass : #TestCase,
	#category : #'GT-SUnitDebugger'
}

{ #category : #'as yet unclassified' }
GTFailingTest >> testFail [

	self assert: 'I like pie  
pizza pie 
apple pie 
rad squared pi 
and other PIes'
	equals: 'I like pie  
pizza pie 
potato pie 
rad squared pi 
and other PIes'
]

{ #category : #'as yet unclassified' }
GTFailingTest >> testFailingDate [
	|aDateAndTime|
	
	aDateAndTime :=  DateAndTime localTimeZone: TimeZone default; dosEpoch.
	self assert: (aDateAndTime offset: '0:12:00:00')  equals: '1980-01-01T13:00:00+12:00' asDateAndTime
]
