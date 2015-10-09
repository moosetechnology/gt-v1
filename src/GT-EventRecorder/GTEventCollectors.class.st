Class {
	#name : #GTEventCollectors,
	#superclass : #Object,
	#instVars : [
		'mutex',
		'collectors'
	],
	#category : #'GT-EventRecorder-Core'
}

{ #category : #adding }
GTEventCollectors >> add: aGTEventCollector [
	^ mutex critical: [ collectors addLast: aGTEventCollector ]
]

{ #category : #'as yet unclassified' }
GTEventCollectors >> do: oneArgBlock [
	mutex critical: [ collectors do: oneArgBlock ]
]

{ #category : #'as yet unclassified' }
GTEventCollectors >> gtInspectorItemsIn: composite [
	<gtInspectorPresentationOrder: 1>
	^ collectors ifNotNil: [ 
			(collectors gtInspectorItemsIn: composite)
				title: 'Collectors' ]
]

{ #category : #initialization }
GTEventCollectors >> initialize [
	super initialize.
	mutex := Mutex new.
	collectors := OrderedCollection new.
]

{ #category : #'as yet unclassified' }
GTEventCollectors >> numberOfEvents [
	^ mutex critical: [ collectors sum: #size ]
]

{ #category : #'as yet unclassified' }
GTEventCollectors >> printOn: aStream [
	super printOn: aStream.
	aStream
		space;
		nextPut: $[;
		nextPutAll: (self size pluralize: 'collector');
		nextPutAll: ', ';
		nextPutAll: (self numberOfEvents pluralize: 'event');
		nextPut: $]
]

{ #category : #accessing }
GTEventCollectors >> size [
	^ mutex critical: [ collectors size ]
]
