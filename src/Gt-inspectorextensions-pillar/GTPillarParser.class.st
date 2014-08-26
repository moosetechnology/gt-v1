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
	^ '[[[' asParser, ']]]' asParser negate star flatten token, ']]]' asParser ==> [ :res | res second ]
]

{ #category : #'as yet unclassified' }
GTPillarParser >> codeIsland [
	^ code island ==> #second
]

{ #category : #'as yet unclassified' }
GTPillarParser >> file [
	^ fileLabel optional , filePreamble , fileName
]

{ #category : #'as yet unclassified' }
GTPillarParser >> fileLabel [
	^ (#word asParser plus flatten , $> asParser) flatten
]

{ #category : #'as yet unclassified' }
GTPillarParser >> fileName [ 
	^ (#word asParser / $. asParser) plus flatten
]

{ #category : #'as yet unclassified' }
GTPillarParser >> filePreamble [
	^ 'file://' asParser
]

{ #category : #'as yet unclassified' }
GTPillarParser >> link [
	"TODO: Please, provide exact definition of a link rule"
	^ '+' asParser , file token , '+' asParser ==> [:res | res second ]
]

{ #category : #'as yet unclassified' }
GTPillarParser >> linkIsland [
	^ link island ==> #second
]

{ #category : #'as yet unclassified' }
GTPillarParser >> start [
	^ (codeIsland / linkIsland) star
]
