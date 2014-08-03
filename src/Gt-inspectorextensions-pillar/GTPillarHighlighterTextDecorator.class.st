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
	
	| name filePreamble fileName fileLink |
	name := (#word asParser plus flatten , $> asParser) flatten.
	filePreamble := 'file://' asParser.
	fileName := (#word asParser / $. asParser) plus flatten.
	fileLink := $+ asParser , name optional , filePreamble , fileName , $+ asParser
	 ==> [: t | 
		'' asText join:
		(t 
			at: 4 put: 
				((t at: 4) asText addAttribute: 
					(GTPillarFileTextLink new fileName: (t at: 4)));
			yourself) ].
	^ (fileLink negate star flatten , (fileLink , fileLink negate star flatten ==> [:t | '' asText join: t]) star  
		==> [:t | (t at: 1) , ('' asText join: (t at: 2)) ] ) parse: aText 
]
