Class {
	#name : #GTSpotterSessions,
	#superclass : #OrderedCollection,
	#traits : 'TGTSpotterDurationView',
	#classTraits : 'TGTSpotterDurationView classTrait',
	#category : #'GT-Spotter-EventRecorder-Analysis'
}

{ #category : #'as yet unclassified' }
GTSpotterSessions >> duration [
	^ self stop - self start
]

{ #category : #helpers }
GTSpotterSessions >> numberOfEvents [
	^ self sum: #size
]

{ #category : #'as yet unclassified' }
GTSpotterSessions >> sessions [
	^ self
]

{ #category : #'as yet unclassified' }
GTSpotterSessions >> start [
	^ (self detectMin: #start) ifNil: [ 0 ] ifNotNil: [ :obj | obj start ]
]

{ #category : #'as yet unclassified' }
GTSpotterSessions >> stop [
	^ (self detectMax: #stop)  ifNil: [ 0 ] ifNotNil: [ :obj | obj stop ]
]
