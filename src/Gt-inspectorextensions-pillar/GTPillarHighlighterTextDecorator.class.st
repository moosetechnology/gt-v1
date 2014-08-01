Class {
	#name : #GTPillarHighlighterTextDecorator,
	#superclass : #GLMHighlighterTextDecorator,
	#category : #'GT-InspectorExtensions-Pillar'
}

{ #category : #'as yet unclassified' }
GTPillarHighlighterTextDecorator class >> key [
	^ self name
]

{ #category : #'as yet unclassified' }
GTPillarHighlighterTextDecorator >> parse: aString [
	
	String cr asText join:
(aString lines collect: [:each | 
		(each beginsWith: '!') ifTrue: [ 
			each asText makeAllColor: Color blue ] ifFalse: [ each asText ] ]).
]

{ #category : #'as yet unclassified' }
GTPillarHighlighterTextDecorator >> parse: aString onError: anError [
	
	^ String cr asText join: (
		aString asString lines collect: [:each | 
			(each beginsWith: '!') ifTrue: [ 
				each asText makeAllColor: Color blue ] ifFalse: [ each asText ] ]).
]

{ #category : #'as yet unclassified' }
GTPillarHighlighterTextDecorator >> parser [
	^ self
]
