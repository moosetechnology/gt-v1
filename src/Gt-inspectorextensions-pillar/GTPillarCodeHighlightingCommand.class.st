Class {
	#name : #GTPillarCodeHighlightingCommand,
	#superclass : #GTHighlightingCommand,
	#category : #'GT-InspectorExtensions-Pillar'
}

{ #category : #'as yet unclassified' }
GTPillarCodeHighlightingCommand >> executeOn: aText [
	aText addAttribute: (TextColor red) from: self token start to: self token stop
]
