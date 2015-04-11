Class {
	#name : #GTATimelineBuilderTest,
	#superclass : #TestCase,
	#instVars : [
		'builder'
	],
	#category : #'GT-Spotter-EventRecorder-Analysis-Roassal'
}

{ #category : #'as yet unclassified' }
GTATimelineBuilderTest >> session1 [
	^ GTASessionExamples session1
]

{ #category : #running }
GTATimelineBuilderTest >> setUp [
	super setUp.
	builder := GTATimelineBuilder new.
]

{ #category : #running }
GTATimelineBuilderTest >> testBuild [
	| events |
	events := GTSpotterSession new.
	GTSpotterRecorderEvent allSubclassesDo: [ :eachClass |
		events add: eachClass new.
	].
	builder data: events.
	builder build.
	builder view inspect.
]

{ #category : #running }
GTATimelineBuilderTest >> testBuildSession1 [
	| events |
	events := self session1.
	GTSpotterSessionAnalysis updateOn: events.
	builder data: events.
	builder build.
	RTHorizontalLineLayout on: builder view elements.
	builder view inspect.
]
