Class {
	#name : #GTPillarHighlighterTextDecorator,
	#superclass : #GLMHighlighterTextDecorator,
	#instVars : [
		'presentation',
		'fileReference'
	],
	#category : #'GT-InspectorExtensions-Pillar'
}

{ #category : #'as yet unclassified' }
GTPillarHighlighterTextDecorator class >> inPresentation: aGLMRubricPresentation [
	^ self new presentation: aGLMRubricPresentation 
]

{ #category : #'as yet unclassified' }
GTPillarHighlighterTextDecorator class >> inPresentation: aGLMRubricPresentation fileReference: aFileReference [
	^ self new 
		presentation: aGLMRubricPresentation;
		fileReference: aFileReference 
]

{ #category : #'as yet unclassified' }
GTPillarHighlighterTextDecorator class >> key [
	^ self name
]

{ #category : #accessing }
GTPillarHighlighterTextDecorator >> fileReference [
	^ fileReference
]

{ #category : #accessing }
GTPillarHighlighterTextDecorator >> fileReference: anObject [
	fileReference := anObject
]

{ #category : #'as yet unclassified' }
GTPillarHighlighterTextDecorator >> parse: aString onError: anError [
	| result |
	result := aString asText.
	(GTPillarParser new parse: aString) do: [ :each | 
		each 
			executeOn: result 
			inPresentation: self presentation 
			relativeToFileReference: self fileReference ].
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
