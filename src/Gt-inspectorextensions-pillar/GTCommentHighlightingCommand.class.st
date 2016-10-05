Class {
	#name : #GTCommentHighlightingCommand,
	#superclass : #GTHighlightingCommand,
	#category : #'GT-InspectorExtensions-Pillar'
}

{ #category : #execute }
GTCommentHighlightingCommand >> executeOn: aText inPresentation: aPresentation relativeToFileReference: aFileReference [
	aText 
		addAttribute: (TextColor color: Color gray)
		from: self start 
		to: self stop
]
