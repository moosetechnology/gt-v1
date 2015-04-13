Class {
	#name : #GTATimelineBuilderTest,
	#superclass : #TestCase,
	#instVars : [
		'builder'
	],
	#category : #'GT-Spotter-EventRecorder-Analysis-Roassal'
}

{ #category : #accessing }
GTATimelineBuilderTest >> session1 [
	^ GTASessionExamples session1
]

{ #category : #running }
GTATimelineBuilderTest >> setUp [
	super setUp.
	builder := GTATimelineBuilder new.
]

{ #category : #tests }
GTATimelineBuilderTest >> testBuild [
	| events |
	events := GTSpotterSession new.
	GTSpotterRecorderEvent allSubclassesDo: [ :eachClass |
		events add: eachClass new.
	].
	builder events: events.
	builder build.
	builder view.
]

{ #category : #tests }
GTATimelineBuilderTest >> testBuildSession1 [
	| events |
	events := self session1.
	builder
		events: events;
		analyze;
		withEdges.
	builder interaction 
		popupText: #asEventAnalysisString;
		draggable.
	builder build.
	"builder view inspect."
]
