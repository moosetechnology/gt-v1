Class {
	#name : #GTAMenuBuilder,
	#superclass : #Object,
	#instVars : [
		'timelineBuilder',
		'menuBuilder'
	],
	#category : #'GT-Spotter-EventRecorder-Analysis-Roassal-Activity'
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
GTAMenuBuilder >> colorCloseEventsPerCategory [
	| elements labels normalizer |
	elements := timelineBuilder view elements select: [ :el | el model isCloseSpotter ].
	labels := ((elements collect: [ :e | e model selectedCategoryLabel ]) as: Bag) sortedCounts collect: #value.
	normalizer := RTMultiLinearColorForIdentity new.
	normalizer objects: labels.
	elements do: [ :element | | label |
		label := element model selectedCategoryLabel.
		element trachelShape allVisibleColor: (normalizer rtValue: label) ].
	timelineBuilder view signalUpdate
]

{ #category : #'event handling' }
GTAMenuBuilder >> colorMostOftenQueriesAndItemsInComputer [
	| els bag hashes counts normalizer computers |
	els := timelineBuilder view elements select: [ :el | 
					el model isSpotterEvent and: [ el model userQueryOrSelectionHashes notEmpty ] ].
	computers := els collect: [ :e | e model session computer ] as: Set.
	bag := (computers flatCollect: [ :e | e userQueryOrSelectionHashes collect: #hash ]) as: Bag.
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
GTAMenuBuilder >> colorMostOftenQueriesAndItemsInView [
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
GTAMenuBuilder >> colorSameQueriesAndItemsInComputer [
	| els bag hashes counts normalizer computers |
	els := timelineBuilder view elements select: [ :el | 
					el model isSpotterEvent and: [ el model userQueryOrSelectionHashes notEmpty ] ].
	computers := els collect: [ :e | e model session computer ] as: Set.
	bag := (computers flatCollect: [ :e | e userQueryOrSelectionHashes ]) as: Bag.
	counts := bag sortedCounts.
	hashes := (counts collect: #value) reverse.
	normalizer := RTMultiLinearColorForIdentity new.
	normalizer objects: hashes.
	els do: [ :element | | maxHash |
	maxHash := element model userQueryOrSelectionHashes detectMax: [ :each | bag valuesAndCounts at: each ].
	element trachelShape allVisibleColor: (normalizer rtValue: maxHash) ].
	timelineBuilder view signalUpdate
]

{ #category : #'event handling' }
GTAMenuBuilder >> colorSameQueriesAndItemsInView [
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
	menuBuilder menu: 'Edge' submenu: 'Remove Edges' callback: [ self removeEdges ].
	menuBuilder menu: 'Edge' submenu: 'Add Edges' callback: [ self addEdges ].
	menuBuilder menu: 'Shape' submenu: 'Orthogonal Shapes' callback: [ self orthogonalShapes ].
	menuBuilder menu: 'Shape' submenu: 'Flexible Result Shapes' callback: [ self flexibleResultShapes ].
	menuBuilder menu: 'Color' submenu: 'Same Queries and Items in View' callback: [ self colorSameQueriesAndItemsInView ].
	menuBuilder menu: 'Color' submenu: 'Most Often Queries and Items in View' callback: [ self colorMostOftenQueriesAndItemsInView ].
	menuBuilder menu: 'Color' submenu: 'Same Queries and Items in Computer' callback: [ self colorSameQueriesAndItemsInComputer ].
	menuBuilder menu: 'Color' submenu: 'Most Often Queries and Items in Computer' callback: [ self colorMostOftenQueriesAndItemsInComputer ].
	menuBuilder menu: 'Color' submenu: 'ActOn and Exit Events per Category' callback: [ self colorCloseEventsPerCategory ].

]

{ #category : #accessing }
GTAMenuBuilder >> timelineBuilder: aGTATimelineBuilder [ 
	timelineBuilder := aGTATimelineBuilder
]
