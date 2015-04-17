Class {
	#name : #GTATimelineShapeBuilders,
	#superclass : #OrderedCollection,
	#category : #'GT-Spotter-EventRecorder-Analysis-Roassal'
}

{ #category : #shapes }
GTATimelineShapeBuilders >> oblique [
	self do: #oblique
]

{ #category : #shapes }
GTATimelineShapeBuilders >> orthogonal [
	self do: #orthogonal
]

{ #category : #accessing }
GTATimelineShapeBuilders >> shape [
	self ifEmpty: [ ^ nil ].
	^ self anyOne shape
]