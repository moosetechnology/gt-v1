"
A simple browser showing the list of examples for a given class.
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
		format: [ :pragmaExamplePair | pragmaExamplePair value gtDisplayString ];
		send: [ :pragmaExamplePair | pragmaExamplePair value ];
		morphicSelectionAct: [ :list | 
			list rawSelection key method browse ] 
			icon: GLMUIThemeExtraIcons glamorousBrowse 
			on: $b 
			entitled: 'Browse source';
		selectionPopulate: #selection 
			on: $o 
			entitled: 'Open source' 
			with: [ :list | list rawSelection key method asRingDefinition ]
]

{ #category : #private }
GTExamplesBrowser >> examplesFor: anObject [
	| pragmas |
	pragmas := Pragma 
				allNamed: #gtExample 
				in: anObject class.
	^ pragmas collect: [ :eachPragma | eachPragma -> (anObject perform: eachPragma selector) ]

]
