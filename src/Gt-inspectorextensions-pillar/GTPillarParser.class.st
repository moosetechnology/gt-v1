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
		'file',
		'headingIsland',
		'heading',
		'embed',
		'embedIsland',
		'url',
		'urlLabel',
		'urlName',
		'fileSetting',
		'note',
		'noteIsland',
		'codeLanguage',
		'commentIsland',
		'comment'
	],
	#category : #'GT-InspectorExtensions-Pillar'
}

{ #category : #'as yet unclassified' }
GTPillarParser >> code [
	"TODO: provide more precise definition of a code rule"
	^ #startOfLine asParser , '[[[' asParser , codeLanguage optional ,  
	(#startOfLine asParser , ']]]' asParser) negate star flatten token ,
	#startOfLine asParser , ']]]' asParser ==> [ :res | 
		GTPillarCodeHighlightingCommand new 
			language: res third;
			token: res fourth ] 
]

{ #category : #'as yet unclassified' }
GTPillarParser >> codeIsland [
	^ code sea ==> #second
]

{ #category : #'as yet unclassified' }
GTPillarParser >> codeLanguage [
	^ 'language=' asParser , #word asParser plus flatten ==> #second
]

{ #category : #'as yet unclassified' }
GTPillarParser >> comment [
	^ #startOfLine asParser , ('%' asParser , #newline asParser negate star) token ==> [:res | 
		GTCommentHighlightingCommand new token: res second]
]

{ #category : #'as yet unclassified' }
GTPillarParser >> commentIsland [
	^ comment sea ==> #second
]

{ #category : #'as yet unclassified' }
GTPillarParser >> embed [
	^ '+' asParser , file token , '+' asParser ==> [:res | 
		GTPillarFileHighlightingCommand new 
			token: res second]
]

{ #category : #'as yet unclassified' }
GTPillarParser >> embedIsland [
	^ embed sea ==> #second
]

{ #category : #'as yet unclassified' }
GTPillarParser >> file [
	^ fileLabel optional , filePreamble , fileName , fileSetting star ==> #third
]

{ #category : #'as yet unclassified' }
GTPillarParser >> fileLabel [
	^ ($> asParser / $+ asParser / $| asParser) negate plus flatten , $> asParser
]

{ #category : #'as yet unclassified' }
GTPillarParser >> fileName [ 
	^ ($+ asParser / $| asParser) negate plus flatten
]

{ #category : #'as yet unclassified' }
GTPillarParser >> filePreamble [
	^ 'file://' asParser
]

{ #category : #'as yet unclassified' }
GTPillarParser >> fileSetting [
	^ $| asParser , ($+ asParser / $| asParser) negate plus
]

{ #category : #'as yet unclassified' }
GTPillarParser >> heading [
	^ #startOfLine asParser , ($! asParser , #newline asParser negate star) token ==> [:res | 
		GTHeadingHighlightingCommand new token: res second]
]

{ #category : #'as yet unclassified' }
GTPillarParser >> headingIsland [
	^ heading sea ==> #second
]

{ #category : #'as yet unclassified' }
GTPillarParser >> link [
	^ '*' asParser , url token , '*' asParser ==> [:res | 
		GTPillarLinkHighlightingCommand new token: res second]
]

{ #category : #'as yet unclassified' }
GTPillarParser >> linkIsland [
	^ link sea ==> #second
]

{ #category : #'as yet unclassified' }
GTPillarParser >> note [
	^ #startOfLine asParser , ('@@' asParser , #newline asParser negate star) token ==> [:res | 
		GTNoteHighlightingCommand new token: res second]
]

{ #category : #'as yet unclassified' }
GTPillarParser >> noteIsland [
	^ note sea ==> #second
]

{ #category : #'as yet unclassified' }
GTPillarParser >> start [
	^ (codeIsland / linkIsland / embedIsland / headingIsland / noteIsland / commentIsland ) star
]

{ #category : #'as yet unclassified' }
GTPillarParser >> url [
	^ urlLabel optional , urlName ==> #second
]

{ #category : #'as yet unclassified' }
GTPillarParser >> urlLabel [
	^ (($> asParser / $* asParser) negate plus flatten , $> asParser) flatten
]

{ #category : #'as yet unclassified' }
GTPillarParser >> urlName [ 
	^ $* asParser negate plus flatten
]
