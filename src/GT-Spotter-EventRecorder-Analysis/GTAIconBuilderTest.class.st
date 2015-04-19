"
A GTATimelineIconBuilderTest is a test class for testing the behavior of GTATimelineIconBuilder
"
Class {
	#name : #GTAIconBuilderTest,
	#superclass : #TestCase,
	#instVars : [
		'builder'
	],
	#category : #'GT-Spotter-EventRecorder-Analysis-Roassal'
}

{ #category : #running }
GTAIconBuilderTest >> setUp [
	super setUp.
	builder := GTAIconBuilder new.
	
]

{ #category : #tests }
GTAIconBuilderTest >> testShapeFor [
	| shape view |
	view := RTView new.
	GTSpotterRecorderEvent allSubclassesDo: [ :eachClass |
		shape := builder shapeFor: eachClass new.
		shape ifNotNil: [
			view add: shape element ]
	].
	RTHorizontalLineLayout on: view elements.
	view
]
