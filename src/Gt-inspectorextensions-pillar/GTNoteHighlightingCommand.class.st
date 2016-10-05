Class {
	#name : #GTNoteHighlightingCommand,
	#superclass : #GTHighlightingCommand,
	#category : #'GT-InspectorExtensions-Pillar'
}

{ #category : #execute }
GTNoteHighlightingCommand >> executeOn: aText inPresentation: aPresentation relativeToFileReference: aFileReference [
	aText 
		addAttribute: (TextColor color: Color red muchDarker)
		from: self start 
		to: self stop
]
