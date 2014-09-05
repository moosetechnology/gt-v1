Class {
	#name : #GTCommentHighlightingCommand,
	#superclass : #GTHighlightingCommand,
	#category : #'GT-InspectorExtensions-Pillar'
}

{ #category : #'as yet unclassified' }
GTCommentHighlightingCommand >> executeOn: aText inPresentation: aPresentation relativeToFileReference: aFileReference [
	aText 
		addAttribute: (TextColor color: Color gray)
		from: self token start 
		to: self token stop
]
