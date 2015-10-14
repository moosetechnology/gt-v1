"
A GTEventPackingTest is a test class for testing the behavior of GTEventPacking
"
Class {
	#name : #GTEventPackingTest,
	#superclass : #TestCase,
	#instVars : [
		'packing'
	],
	#category : #'GT-EventRecorder-Tests-Core'
}

{ #category : #testing }
GTEventPackingTest class >> isAbstract [
	^ self name = GTEventPackingTest name
]

{ #category : #accessing }
GTEventPackingTest >> packingClass [
	^ self subclassResponsibility
]

{ #category : #running }
GTEventPackingTest >> setUp [
	super setUp.
	packing := self packingClass new.
]

{ #category : #'tests-packing' }
GTEventPackingTest >> testPack [
	| event1 event2 bundle  announcement collector unpackedData |
	event1 := GTDummyEvent new data: 'string'.
	event2 := GTDummyEvent new data: 42.
	collector := GTEventCollector new.
	collector add: event1; add: event2.
	bundle := packing pack: collector.
	self assert: bundle url equals: collector url.
	self assert: bundle data isLiteral.
	announcement := packing unpack: bundle data.
	unpackedData := announcement unpackedData.
	self assert: unpackedData size equals: 2.
	self assert: unpackedData first equals: event1.
	self assert: unpackedData second equals: event2.

]
