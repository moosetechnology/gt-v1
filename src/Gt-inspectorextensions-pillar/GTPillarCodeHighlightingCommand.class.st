Class {
	#name : #GTPillarCodeHighlightingCommand,
	#superclass : #GTHighlightingCommand,
	#instVars : [
		'language'
	],
	#category : #'GT-InspectorExtensions-Pillar'
}

{ #category : #'as yet unclassified' }
GTPillarCodeHighlightingCommand >> executeOn: aText inPresentation: aPresentation relativeToFileReference: aFileReference [
	| styler styledText |
	self isSmalltalk
		ifTrue: [ 
			styler := SHTextStylerST80 new.
			styler classOrMetaClass: nil.
			styledText := styler styledTextFor: (aText copyFrom: self token start to: self token stop).
			aText replaceFrom: self token start to: self token stop with: styledText ]
		ifFalse: [ 
			aText 
				addAttribute: TextColor black
				from: self token start 
				to: self token stop ].
	aText 
		addAttribute: (TextFontReference toFont: StandardFonts codeFont)
		from: self token start 
		to: self token stop.
]

{ #category : #accessing }
GTPillarCodeHighlightingCommand >> isSmalltalk [ 
	^ self language asLowercase = 'smalltalk'
]

{ #category : #accessing }
GTPillarCodeHighlightingCommand >> language [
	^ language ifNil: [ language := 'smalltalk' ]
]

{ #category : #accessing }
GTPillarCodeHighlightingCommand >> language: anObject [
	language := anObject
]
