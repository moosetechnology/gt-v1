Class {
	#name : #GTPillarLinkHighlightingCommand,
	#superclass : #GTHighlightingCommand,
	#category : #'GT-InspectorExtensions-Pillar'
}

{ #category : #accessing }
GTPillarLinkHighlightingCommand >> executeOn: aText inPresentation: aPresentation relativeToFileReference: aFileReference [
	| attribute |
	attribute := GTPillarFileTextLink new
									fileReference: self token parsedValue;
									presentation: aPresentation.
	aText 
		addAttribute: attribute
		from: self token start 
		to: self token stop.
]
