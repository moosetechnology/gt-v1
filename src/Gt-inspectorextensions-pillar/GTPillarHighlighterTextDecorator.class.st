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
GTPillarHighlighterTextDecorator >> parse: aString onError: anError [
	| result |
	result := aString asText.
	self treatFileLinks: result.
	^ result
	"| line |
	^ String cr asText join: (
		aString asString lines collect: [:each | 
			(each beginsWith: '!') 
				ifTrue: [ each asText makeAllColor: Color blue darker ]
				ifFalse: [ 
					line := each asText. 
					self treatFileLinks: line.
					line ]
	])"
]

{ #category : #'as yet unclassified' }
GTPillarHighlighterTextDecorator >> parser [
	^ self
]

{ #category : #'as yet unclassified' }
GTPillarHighlighterTextDecorator >> treatFileLinks: aText [
	
	(GTPillarParser new parse: aText asString)
		do: [ :each | 
			each executeOn: aText  ]
]
