Class {
	#name : #GTPillarHighlighterTextDecorator,
	#superclass : #GLMHighlighterTextDecorator,
	#instVars : [
		'presentation'
	],
	#category : #'GT-InspectorExtensions-Pillar'
}

{ #category : #'as yet unclassified' }
GTPillarHighlighterTextDecorator class >> inPresentation: aGLMRubricPresentation [
	^ self new presentation: aGLMRubricPresentation 
]

{ #category : #'as yet unclassified' }
GTPillarHighlighterTextDecorator class >> key [
	^ self name
]

{ #category : #'as yet unclassified' }
GTPillarHighlighterTextDecorator >> parse: aString onError: anError [
	| result |
	result := aString asText.
	(GTPillarParser new parse: aString) do: [ :each | 
		each executeOn: result inPresentation: self presentation ].
	^ result
]

{ #category : #'as yet unclassified' }
GTPillarHighlighterTextDecorator >> parser [
	^ self
]

{ #category : #accessing }
GTPillarHighlighterTextDecorator >> presentation [
	^ presentation
]

{ #category : #accessing }
GTPillarHighlighterTextDecorator >> presentation: anObject [
	presentation := anObject
]
