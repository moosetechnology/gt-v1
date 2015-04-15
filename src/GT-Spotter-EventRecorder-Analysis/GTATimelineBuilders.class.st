Class {
	#name : #GTATimelineBuilders,
	#superclass : #OrderedCollection,
	#category : #'GT-Spotter-EventRecorder-Analysis-Roassal'
}

{ #category : #adding }
GTATimelineBuilders >> addEdges [
	self do: #addEdges
]

{ #category : #building }
GTATimelineBuilders >> build [
	self do: #build
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
	self do: #layoutElements
]

{ #category : #configuration }
GTATimelineBuilders >> logicalLayout [
	self do: #logicalLayout
]

{ #category : #configuration }
GTATimelineBuilders >> realLayout [
	self do: #realLayout
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
