"
A GTEventCollectorTest is a test class for testing the behavior of GTEventCollector
"
Class {
	#name : #GTEventCollectorTest,
	#superclass : #TestCase,
	#instVars : [
		'collector'
	],
	#category : #'GT-EventRecorder-Tests-Core'
}

{ #category : #running }
GTEventCollectorTest >> setUp [
	super setUp.
	collector := GTEventCollector new
]

{ #category : #tests }
GTEventCollectorTest >> testBundle [
	self assert: collector bundle isEmpty
]

{ #category : #tests }
GTEventCollectorTest >> testBundle2 [
	collector add: GTDummyEvent new.
	collector add: GTDummyEvent new.
	self assert: collector bundle size equals: 2.
	self assert: collector bundle isEmpty.
]

{ #category : #tests }
GTEventCollectorTest >> testUrl [
	self assert: collector url notNil.
	self assert: collector url equals: GTEventRecorderSettings url.
]