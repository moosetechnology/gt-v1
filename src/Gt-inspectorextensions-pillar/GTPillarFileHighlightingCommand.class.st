Class {
	#name : #GTPillarFileHighlightingCommand,
	#superclass : #GTHighlightingCommand,
	#category : #'GT-InspectorExtensions-Pillar'
}

{ #category : #accessing }
GTPillarFileHighlightingCommand >> executeOn: aText [
	aText addAttribute: (GTPillarFileTextLink new fileName: self token parsedValue) from: self token start to: self token stop
]
