Class {
	#name : #GTPillarFileHighlightingCommand,
	#superclass : #GTHighlightingCommand,
	#instVars : [
		'fileName'
	],
	#category : #'GT-InspectorExtensions-Pillar'
}

{ #category : #accessing }
GTPillarFileHighlightingCommand >> executeOn: aText inPresentation: aPresentation relativeToFileReference: aFileReference [
	| attribute targetFileReference |
	targetFileReference := aFileReference parent resolveString: (self fileName removePrefix: 'file://').
	attribute := targetFileReference exists 
		ifTrue: [ GTPillarFileTextLink new
									fileReference: targetFileReference;
									presentation: aPresentation ]
		ifFalse: [ TextColor red ].
	aText 
		addAttribute: attribute
		from: self start 
		to: self stop.
]

{ #category : #accessing }
GTPillarFileHighlightingCommand >> fileName [
	^ fileName
]

{ #category : #accessing }
GTPillarFileHighlightingCommand >> fileName: anObject [
	fileName := anObject
]
