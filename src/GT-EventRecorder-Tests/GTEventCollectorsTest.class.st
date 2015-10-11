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
GTEventCollectorsTest >> testPrintOn [
	self assert: (String streamContents: [ :stream | collectors printOn: stream ]) notEmpty.
]
