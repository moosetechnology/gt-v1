Class {
	#name : #GTSpotterDiveInLevelCommand,
	#superclass : #GTSpotterAnalysisCommand,
	#instVars : [
		'dives'
	],
	#category : #'GT-Spotter-EventRecorder-Analysis-Builders'
}

{ #category : #execute }
GTSpotterDiveInLevelCommand >> execute [
	self session do: [ :eachEvent |
		eachEvent isDiveIn ifTrue: [ self updateDiveIn: eachEvent ].
		eachEvent isDiveOut ifTrue: [ self updateDiveOut: eachEvent ].
		eachEvent isDive ifFalse: [ self updateEvent: eachEvent ].
	]
]

{ #category : #initialization }
GTSpotterDiveInLevelCommand >> initialize [
	super initialize.
	dives := OrderedCollection new
]

{ #category : #update }
GTSpotterDiveInLevelCommand >> updateDiveIn: anEvent [
	dives ifNotEmpty: [ 
		anEvent parentDiveInEvent: dives last.
		dives last childDiveInEvent: anEvent ].
	dives add: anEvent.

]

{ #category : #update }
GTSpotterDiveInLevelCommand >> updateDiveOut: anEvent [
	dives ifEmpty: [ ^ anEvent markAsStrange: 'Dive-Out before Dive-In.' ].
	anEvent parentDiveInEvent: dives last.
	dives last diveOutEvent: anEvent.
	dives removeLast 
]

{ #category : #update }
GTSpotterDiveInLevelCommand >> updateEvent: anEvent [
	dives ifEmpty: [ ^ self ].
	anEvent diveInEvent: dives last.
	dives last addSameLevelEvent: anEvent.

]
