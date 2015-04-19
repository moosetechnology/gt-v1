Class {
	#name : #GTAMenuBuilder,
	#superclass : #Object,
	#instVars : [
		'timelineBuilder',
		'menuBuilder'
	],
	#category : #'GT-Spotter-EventRecorder-Analysis-Roassal'
}

{ #category : #'event handling' }
GTAMenuBuilder >> addEdges [
	timelineBuilder withEdges; addEdges; signalUpdate.
	self configuration withEdges: timelineBuilder isWithEdges.
]

{ #category : #building }
GTAMenuBuilder >> build [
	self renderIn: timelineBuilder view.
]

{ #category : #'event handling' }
GTAMenuBuilder >> colorMostOftenQueriesAndItems [
	| els bag hashes counts normalizer |
	els := timelineBuilder view elements select: [ :el | 
					el model isSpotterEvent and: [ el model userQueryOrSelectionHashes notEmpty ] ].
	bag := (els flatCollect: [ :e | e model userQueryOrSelectionHashes ]) as: Bag.
	counts := bag sortedCounts.
	hashes := (counts collect: #value) reverse.
	normalizer := RTGrayLinearColor new.
	normalizer command: #yourself; scope: hashes.
	els do: [ :element | | maxHash |
	maxHash := element model userQueryOrSelectionHashes detectMax: [ :each | bag valuesAndCounts at: each ].
	element trachelShape allVisibleColor: (normalizer rtValue: maxHash) ].
	timelineBuilder view signalUpdate
]

{ #category : #'event handling' }
GTAMenuBuilder >> colorSameQueriesAndItems [
	| els bag hashes counts normalizer |
	els := timelineBuilder view elements select: [ :el | 
					el model isSpotterEvent and: [ el model userQueryOrSelectionHashes notEmpty ] ].
	bag := (els flatCollect: [ :e | e model userQueryOrSelectionHashes ]) as: Bag.
	counts := bag sortedCounts.
	hashes := (counts collect: #value) reverse.
	normalizer := RTMultiLinearColorForIdentity new.
	normalizer objects: hashes.
	els do: [ :element | | maxHash |
	maxHash := element model userQueryOrSelectionHashes detectMax: [ :each | bag valuesAndCounts at: each ].
	element trachelShape allVisibleColor: (normalizer rtValue: maxHash) ].
	timelineBuilder view signalUpdate
]

{ #category : #accessing }
GTAMenuBuilder >> configuration [
	^ GTADefaultTimelineConfiguration uniqueInstance
]

{ #category : #'event handling' }
GTAMenuBuilder >> flexibleResultShapes [
	timelineBuilder shape flexibleResultShapes.
	timelineBuilder 
		removeAllElementsAndEdges;
	 	build;
		signalUpdate.
	self configuration shape: timelineBuilder shape shape
]

{ #category : #initialization }
GTAMenuBuilder >> initialize [
	super initialize.
	menuBuilder := RTMenuBuilder new.
]

{ #category : #'event handling' }
GTAMenuBuilder >> logicalTimeline [
	timelineBuilder
			logicalLayout;
			layoutElements;
			signalUpdate.
	self configuration 
			layout: timelineBuilder layout
]

{ #category : #'event handling' }
GTAMenuBuilder >> obliqueShapes [
	timelineBuilder shape oblique.
	timelineBuilder 
		removeAllElementsAndEdges;
	 	build;
		signalUpdate.
	self configuration shape: timelineBuilder shape shape
]

{ #category : #'event handling' }
GTAMenuBuilder >> orthogonalShapes [
	timelineBuilder shape orthogonal.
	timelineBuilder 
		removeAllElementsAndEdges;
	 	build;
		signalUpdate.
	self configuration shape: timelineBuilder shape shape
]

{ #category : #'event handling' }
GTAMenuBuilder >> realTimeline [
	timelineBuilder
			realLayout;
			layoutElements;
			signalUpdate.
	self configuration 
		layout: timelineBuilder layout
]

{ #category : #'event handling' }
GTAMenuBuilder >> removeEdges [
	timelineBuilder withoutEdges; removeEdges; signalUpdate.
	self configuration withEdges: timelineBuilder isWithEdges.
]

{ #category : #hooks }
GTAMenuBuilder >> renderIn: aView [
	menuBuilder view: aView.
	menuBuilder menu: 'Layout' submenu: 'Logical Timeline' callback: [ self logicalTimeline ].
	menuBuilder menu: 'Layout' submenu: 'Real Timeline' callback: [ self realTimeline ].
	menuBuilder menu: 'Edges' submenu: 'Remove' callback: [ self removeEdges ].
	menuBuilder menu: 'Edges' submenu: 'Add' callback: [ self addEdges ].
	menuBuilder menu: 'Events' submenu: 'Orthogonal Shapes' callback: [ self orthogonalShapes ].
	menuBuilder menu: 'Events' submenu: 'Flexible Result Shapes' callback: [ self flexibleResultShapes ].
	menuBuilder menu: 'Color' submenu: 'Same queries and items' callback: [ self colorSameQueriesAndItems ].
	menuBuilder menu: 'Color' submenu: 'Most often queries and items' callback: [ self colorMostOftenQueriesAndItems ].
	
]

{ #category : #accessing }
GTAMenuBuilder >> timelineBuilder: aGTATimelineBuilder [ 
	timelineBuilder := aGTATimelineBuilder
]
