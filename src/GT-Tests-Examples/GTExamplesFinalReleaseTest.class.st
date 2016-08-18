Class {
	#name : #GTExamplesFinalReleaseTest,
	#superclass : #TestCase,
	#category : #'GT-Tests-Examples'
}

{ #category : #tests }
GTExamplesFinalReleaseTest >> testNoExampleInstances [

	self assert: GTExample allInstances size equals: 0.
	self assert: GTExampleResult allInstances size equals: 0.
	
]
