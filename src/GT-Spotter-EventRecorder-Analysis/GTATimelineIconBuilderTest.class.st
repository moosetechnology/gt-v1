"
A GTATimelineIconBuilderTest is a test class for testing the behavior of GTATimelineIconBuilder
"
Class {
	#name : #GTATimelineIconBuilderTest,
	#superclass : #TestCase,
	#instVars : [
		'builder'
	],
	#category : #'GT-Spotter-EventRecorder-Analysis-Roassal'
}

{ #category : #running }
GTATimelineIconBuilderTest >> setUp [
	super setUp.
	builder := GTATimelineIconBuilder new.
	
]

{ #category : #tests }
GTATimelineIconBuilderTest >> testSVGPathFor [
	| svgPath shape view |
	view := RTView new.
	GTSpotterRecorderEvent allSubclassesDo: [ :eachClass |
		svgPath := builder svgPathFor: eachClass new.
		svgPath ifNotNil: [
			shape := RTSVGPath new centeredPath: svgPath; yourself.
			view add: shape element ]
	].
	RTHorizontalLineLayout on: view elements.
	view inspect
]
