Class {
	#name : #GTHeadingHighlightingCommand,
	#superclass : #GTHighlightingCommand,
	#category : #'GT-InspectorExtensions-Pillar'
}

{ #category : #'as yet unclassified' }
GTHeadingHighlightingCommand >> executeOn: aText inPresentation: aPresentation relativeToFileReference: aFileReference [
	aText 
		addAttribute: TextColor gray
		from: self token start 
		to: self token stop
]
