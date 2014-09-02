Class {
	#name : #GTPillarParser,
	#superclass : #PPCompositeParser,
	#instVars : [
		'code',
		'link',
		'codeIsland',
		'linkIsland',
		'fileLabel',
		'filePreamble',
		'fileName',
		'file'
	],
	#category : #'GT-InspectorExtensions-Pillar'
}

{ #category : #'as yet unclassified' }
GTPillarParser >> code [
	"TODO: provide more precise definition of a code rule"
	^ '[[[' asParser, ']]]' asParser negate star flatten token, ']]]' asParser ==> [ :res | 
		GTPillarCodeHighlightingCommand new token: res second ]
]

{ #category : #'as yet unclassified' }
GTPillarParser >> codeIsland [
	^ code island ==> #second
]

{ #category : #'as yet unclassified' }
GTPillarParser >> file [
	^ fileLabel optional , filePreamble , fileName ==> #third
]

{ #category : #'as yet unclassified' }
GTPillarParser >> fileLabel [
	^ ($> asParser negate plus flatten , $> asParser) flatten
]

{ #category : #'as yet unclassified' }
GTPillarParser >> fileName [ 
	^ $+ asParser negate plus flatten
]

{ #category : #'as yet unclassified' }
GTPillarParser >> filePreamble [
	^ 'file://' asParser
]

{ #category : #'as yet unclassified' }
GTPillarParser >> link [
	^ '+' asParser , file token , '+' asParser ==> [:res | 
		GTPillarFileHighlightingCommand new 
			token: res second]
]

{ #category : #'as yet unclassified' }
GTPillarParser >> linkIsland [
	^ link island ==> #second
]

{ #category : #'as yet unclassified' }
GTPillarParser >> start [
	^ (codeIsland / linkIsland) star
]
