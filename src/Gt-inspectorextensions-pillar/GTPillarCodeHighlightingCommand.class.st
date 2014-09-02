Class {
	#name : #GTPillarCodeHighlightingCommand,
	#superclass : #GTHighlightingCommand,
	#category : #'GT-InspectorExtensions-Pillar'
}

{ #category : #'as yet unclassified' }
GTPillarCodeHighlightingCommand >> executeOn: aText inPresentation: aPresentation relativeToFileReference: aFileReference [
"	| styler styledText |
	styler := SHTextStylerST80 new.
	styler classOrMetaClass: nil.
	styledText := styler styledTextFor: (aText copyFrom: self token start to: self token stop).
	aText replaceFrom: self token start to: self token stop with: styledText"
	aText 
		addAttribute: TextColor gray
		from: self token start 
		to: self token stop 
]
