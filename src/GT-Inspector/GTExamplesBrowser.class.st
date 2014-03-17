"
A simple browser showing the list of examples for a given class.

For example:
self openOn: FileReference
"
Class {
	#name : #GTExamplesBrowser,
	#superclass : #GLMCompositePresentation,
	#category : #'GT-Inspector'
}

{ #category : #building }
GTExamplesBrowser >> compose [
	self title: 'E.g.'.
	self when: [ :class | (self examplesFor: class) notEmpty ].
	self list
		display: [ :class | self examplesFor: class ];
		format: [ :pragmaExamplePair | pragmaExamplePair result gtDisplayString ];
		send: [ :pragmaExamplePair | pragmaExamplePair result ];
		morphicSelectionAct: [ :list | 
			list rawSelection methodReference browse ] 
			icon: GLMUIThemeExtraIcons glamorousBrowse 
			on: $b 
			entitled: 'Browse source';
		selectionPopulate: #selection 
			on: $o 
			entitled: 'Open source' 
			with: [ :list | list rawSelection methodReference ]
]

{ #category : #private }
GTExamplesBrowser >> examplesFor: anObject [
	| pragmas |
	pragmas := Pragma 
				allNamed: #gtExample 
				in: anObject class.
	^ pragmas collect: [ :eachPragma | 
		GTExample new
			methodReference: eachPragma method asRingDefinition ]

]
