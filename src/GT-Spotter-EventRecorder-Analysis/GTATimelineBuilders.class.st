Class {
	#name : #GTATimelineBuilders,
	#superclass : #OrderedCollection,
	#category : #'GT-Spotter-EventRecorder-Analysis-Roassal-Activity'
}

{ #category : #adding }
GTATimelineBuilders >> addEdges [
	self do: #addEdges
]

{ #category : #building }
GTATimelineBuilders >> build [
	self do: #build.
	self layoutSessions
]

{ #category : #testing }
GTATimelineBuilders >> isWithEdges [
	^ self anyOne isWithEdges
]

{ #category : #accessing }
GTATimelineBuilders >> layout [
	^ self anyOne layout
]

{ #category : #layout }
GTATimelineBuilders >> layoutElements [
	self do: #layoutElements.
	self layoutSessions
]

{ #category : #layout }
GTATimelineBuilders >> layoutSessions [
	| previousBuilder |
	self
		withIndexDo: [ :builder :index | 
			builder layoutElements.
			index > 1
				ifTrue: [ TRConstraint move: builder elements belowAlignFromLeft: previousBuilder elements gap: 20 ].
			previousBuilder := builder ]
]

{ #category : #configuration }
GTATimelineBuilders >> logicalLayout [
	self do: #logicalLayout
]

{ #category : #configuration }
GTATimelineBuilders >> realLayout [
	self do: #realLayout
]

{ #category : #'as yet unclassified' }
GTATimelineBuilders >> removeAllElementsAndEdges [
	self do: #removeAllElementsAndEdges
]

{ #category : #'event handling' }
GTATimelineBuilders >> removeEdges [
	self do: #removeEdges
]

{ #category : #accessing }
GTATimelineBuilders >> shape [
	^ self collect: #shape as: GTATimelineShapeBuilders
]

{ #category : #signalling }
GTATimelineBuilders >> signalUpdate [
	self ifEmpty: [ ^ self ].
	self view signalUpdate
]

{ #category : #accessing }
GTATimelineBuilders >> view [
	^ self anyOne view
]

{ #category : #configuration }
GTATimelineBuilders >> withEdges [
	self do: #withEdges
]

{ #category : #configuration }
GTATimelineBuilders >> withoutEdges [
	self do: #withoutEdges
]
