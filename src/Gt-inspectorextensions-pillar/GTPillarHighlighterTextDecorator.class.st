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
	
	^ String cr asText join: (
		aString asString lines collect: [:each | 
			(each beginsWith: '!') 
				ifTrue: [ each asText makeAllColor: Color blue darker ]
				ifFalse: [ (self treatFileLinks: each) asText ]
	]).
]

{ #category : #'as yet unclassified' }
GTPillarHighlighterTextDecorator >> parser [
	^ self
]

{ #category : #'as yet unclassified' }
GTPillarHighlighterTextDecorator >> treatFileLinks: aText [
	
	| name filePreamble fileName fileLabel fileLink parser |
	name := (#word asParser plus flatten , $> asParser) flatten.
	filePreamble := 'file://' asParser.
	fileName := (#word asParser / $. asParser) plus flatten
		==> [ :t | 
			t asText addAttribute: 
				("GTPillarFileTextLink new fileName: t"
				TextColor color: Color red) ].
	fileLabel := name optional ==> [:t | t ifNil: ['' asText]].
	fileLink := $+ asParser , fileLabel , filePreamble, fileName , $+ asParser
	 ==> [: t | '' asText join: t ].
	parser := ((fileLink / fileLink negate plus flatten ==> [:t | '' asText join: t]) star  
		==> [:t | ('' asText join: t) ] ).
	^ parser parse: aText 
]
