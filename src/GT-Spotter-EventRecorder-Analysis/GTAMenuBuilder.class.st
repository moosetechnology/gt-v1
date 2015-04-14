Class {
	#name : #GTAMenuBuilder,
	#superclass : #Object,
	#instVars : [
		'timelineBuilder',
		'menuBuilder'
	],
	#category : #'GT-Spotter-EventRecorder-Analysis-Roassal'
}

{ #category : #adding }
GTAMenuBuilder >> addEdges [
	timelineBuilder withEdges; addEdges; signalUpdate
]

{ #category : #building }
GTAMenuBuilder >> build [
	self renderIn: timelineBuilder view.
]

{ #category : #initialization }
GTAMenuBuilder >> initialize [
	super initialize.
	menuBuilder := RTMenuBuilder new.
]

{ #category : #'as yet unclassified' }
GTAMenuBuilder >> logicalTimeline [
	timelineBuilder
			logicalLayout;
			layoutElements;
			signalUpdate
]

{ #category : #'as yet unclassified' }
GTAMenuBuilder >> obliqueShapes [
	timelineBuilder shape oblique.
	timelineBuilder 
		removeAll;
	 	build;
		signalUpdate
]

{ #category : #'as yet unclassified' }
GTAMenuBuilder >> orthogonalShapes [
	timelineBuilder shape orthogonal.
	timelineBuilder 
		removeAll;
	 	build;
		signalUpdate
]

{ #category : #'as yet unclassified' }
GTAMenuBuilder >> realTimeline [
	timelineBuilder
			realLayout;
			layoutElements;
			signalUpdate
]

{ #category : #removing }
GTAMenuBuilder >> removeEdges [
	timelineBuilder withoutEdges; removeEdges; signalUpdate
]

{ #category : #hooks }
GTAMenuBuilder >> renderIn: aView [
	menuBuilder view: aView.
	menuBuilder menu: 'Layout' submenu: 'Logical Timeline' callback: [ self logicalTimeline ].
	menuBuilder menu: 'Layout' submenu: 'Real Timeline' callback: [ self realTimeline ].
	menuBuilder menu: 'Edges' submenu: 'Remove' callback: [ self removeEdges ].
	menuBuilder menu: 'Edges' submenu: 'Add' callback: [ self addEdges ].
	menuBuilder menu: 'Events' submenu: 'Orthogonal Shapes' callback: [ self orthogonalShapes ].
	menuBuilder menu: 'Events' submenu: 'Oblique Shapes' callback: [ self obliqueShapes ].

]

{ #category : #accessing }
GTAMenuBuilder >> timelineBuilder: aGTATimelineBuilder [ 
	timelineBuilder := aGTATimelineBuilder
]
