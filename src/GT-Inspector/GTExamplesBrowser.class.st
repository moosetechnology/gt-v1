"
A simple browser showing the list of examples for a given class.

For example:
self openOn: FileReference
"
Class {
	#name : #GTExamplesBrowser,
	#superclass : #GLMCompositePresentation,
	#category : #'GT-Inspector-Examples'
}

{ #category : #building }
GTExamplesBrowser >> compose [
	|exampleProvider|
	
	self title: 'E.g.'.
	self when: [ :class |  class examplesProvider gtExamples notEmpty ].
	self dynamic
		display: [ :class | 
			exampleProvider := class examplesProvider.
			(exampleProvider gtDisplayExamplesIn: GLMCompositePresentation new)
				morphicSelectionAct: [ :list | 
					list rawSelection methodReference browse ] 
					icon: GLMUIThemeExtraIcons glamorousBrowse 
					on: $b 
					entitled: 'Browse source';
				selectionPopulate: #selection 
					on: $o 
					entitled: 'Open source' 
					with: [ :list | list rawSelection methodReference ] ]
		
]
