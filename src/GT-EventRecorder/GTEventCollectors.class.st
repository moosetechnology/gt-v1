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

{ #category : #enumerating }
GTEventCollectors >> do: oneArgBlock [
	mutex critical: [ collectors do: oneArgBlock ]
]

{ #category : #'gt-inspector-extension' }
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

{ #category : #accessing }
GTEventCollectors >> numberOfEvents [
	^ mutex critical: [ 
		collectors 
			ifEmpty: 0
			ifNotEmpty: [ collectors sum: #size ] ]
]

{ #category : #printing }
GTEventCollectors >> printOn: aStream [
	super printOn: aStream.
	aStream
		space;
		nextPut: $[;
		print: self size;
		space;
		nextPutAll: ('collector' asPluralBasedOn: self size);
		nextPutAll: ', ';
		print: self numberOfEvents;
		space;
		nextPutAll: ('event' asPluralBasedOn: self numberOfEvents);
		nextPut: $]
]

{ #category : #removing }
GTEventCollectors >> remove: aGTEventCollector [ 
	^ mutex critical: [ collectors remove: aGTEventCollector ifAbsent: nil ]
]

{ #category : #accessing }
GTEventCollectors >> size [
	^ mutex critical: [ collectors size ]
]
