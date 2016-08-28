Class {
	#name : #GTExamplesFinalReleaseTest,
	#superclass : #TestCase,
	#category : #'GT-Tests-Examples'
}

{ #category : #running }
GTExamplesFinalReleaseTest >> setUp [
	super setUp.
	
	GTExampleOrganizer reset; stop.
	Smalltalk garbageCollect; garbageCollectMost.
]

{ #category : #running }
GTExamplesFinalReleaseTest >> tearDown [
	super tearDown.
	
	GTExampleOrganizer reset; start.
	Smalltalk garbageCollect; garbageCollectMost.
]

{ #category : #tests }
GTExamplesFinalReleaseTest >> testNoExampleInstances [

	self assert: GTExample allSubInstances size equals: 0.
	self assert: GTExampleResult allSubInstances size equals: 0.
	
]
