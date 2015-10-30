"
A GTEventCollectorsTest is a test class for testing the behavior of GTEventCollectors
"
Class {
	#name : #GTEventCollectorsTest,
	#superclass : #TestCase,
	#instVars : [
		'collectors'
	],
	#category : #'GT-EventRecorder-Tests-Core'
}

{ #category : #running }
GTEventCollectorsTest >> setUp [
	super setUp.
	collectors := GTEventCollectors new.
]

{ #category : #tests }
GTEventCollectorsTest >> testAdd [
	collectors add: GTEventCollector new.
	self assert: collectors size equals: 1.
]

{ #category : #tests }
GTEventCollectorsTest >> testAdd2 [
	collectors add: GTEventCollector new.
	collectors add: GTEventCollector new.
	self assert: collectors size equals: 2.
]

{ #category : #tests }
GTEventCollectorsTest >> testAdd3 [
	| collector |
	collector := GTEventCollector new.
	collectors add: collector.
	collectors add: collector.
	self assert: collectors size equals: 1.
]

{ #category : #tests }
GTEventCollectorsTest >> testDefault [
	self assert: collectors size equals: 0.
]

{ #category : #tests }
GTEventCollectorsTest >> testPrintOn [
	self assert: (String streamContents: [ :stream | collectors printOn: stream ]) notEmpty.
]
