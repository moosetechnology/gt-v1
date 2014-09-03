Class {
	#name : #GTPillarLinkHighlightingCommand,
	#superclass : #GTHighlightingCommand,
	#category : #'GT-InspectorExtensions-Pillar'
}

{ #category : #accessing }
GTPillarLinkHighlightingCommand >> executeOn: aText inPresentation: aPresentation relativeToFileReference: aFileReference [
	| attribute target |
	[target := ZnEasy get: self token parsedValue.
	attribute := target isSuccess 
		ifTrue: [ GTPillarFileTextLink new
									fileReference: target contents;
									presentation: aPresentation ]
		ifFalse: [ TextColor red ]]
	on: NameLookupFailure, ZnUnknownScheme do: [attribute := TextColor red].
	aText 
		addAttribute: attribute
		from: self token start 
		to: self token stop.
]
