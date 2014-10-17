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
	self when: [ :class | (self rootExamplesFor: class) notEmpty ].
	self tree
		display: [ :class | self rootExamplesFor: class ];
		children: [ :anExample | anExample childrenExamples ];
		format: [ :anExample | anExample result gtDisplayString ];
		send: [ :pragmaExamplePair | pragmaExamplePair result ];
		allExpanded;
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
GTExamplesBrowser >> rootExamplesFor: anObject [
	| pragmas |

	pragmas := Pragma 
				allNamed: #gtExample 
				in: anObject class.
	^ (pragmas select: [ :each | each selector isUnary ])
		ifEmpty: [ #() ]
		ifNotEmpty: [ :rootPragmas | rootPragmas collect: [ :eachPragma | 
			GTExample fromMethodReference: eachPragma method asRingDefinition ] ]
	
	
	
]
