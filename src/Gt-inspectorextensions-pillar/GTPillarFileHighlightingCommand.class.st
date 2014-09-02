Class {
	#name : #GTPillarFileHighlightingCommand,
	#superclass : #GTHighlightingCommand,
	#category : #'GT-InspectorExtensions-Pillar'
}

{ #category : #accessing }
GTPillarFileHighlightingCommand >> executeOn: aText inPresentation: aPresentation relativeToFileReference: aFileReference [
	| attribute targetFileReference |
	targetFileReference := aFileReference parent resolveString: self token parsedValue.
	attribute := targetFileReference exists 
		ifTrue: [ GTPillarFileTextLink new
									fileReference: targetFileReference;
									presentation: aPresentation ]
		ifFalse: [ TextColor red ].
	aText 
		addAttribute: attribute
		from: self token start 
		to: self token stop.
]
