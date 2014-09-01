Class {
	#name : #GTHighlightingCommand,
	#superclass : #Object,
	#instVars : [
		'token'
	],
	#category : #'GT-InspectorExtensions-Pillar'
}

{ #category : #accessing }
GTHighlightingCommand >> executeOn: aText [
	self subclassResponsibility 
]

{ #category : #accessing }
GTHighlightingCommand >> executeOn: aText inPresentation: aPresentation [
	self subclassResponsibility 
]

{ #category : #accessing }
GTHighlightingCommand >> token [
	^ token
]

{ #category : #accessing }
GTHighlightingCommand >> token: anObject [
	token := anObject
]
