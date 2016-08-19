Class {
	#name : #GTExamplesFinalReleaseTest,
	#superclass : #TestCase,
	#category : #'GT-Tests-Examples'
}

{ #category : #running }
GTExamplesFinalReleaseTest >> setUp [
	super setUp.
	
	GTExampleOrganizer reset; stop.
	Smalltalk garbageCollect
]

{ #category : #running }
GTExamplesFinalReleaseTest >> tearDown [
	super tearDown.
	
	GTExampleOrganizer reset; start.
	Smalltalk garbageCollect.
]

{ #category : #tests }
GTExamplesFinalReleaseTest >> testNoExampleInstances [

	self assert: GTExample allInstances size equals: 0.
	self assert: GTExampleResult allInstances size equals: 0.
	
]
