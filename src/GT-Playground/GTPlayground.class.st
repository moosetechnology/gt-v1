"
self openOn: GTPlayground new.


Playground is the correspondent of a classic Smalltalk Workspace. The problem with the name Workspace is that it implies that work should be carried out in this space, while this is not a best practice. Playground describes better the intention of providing a place in which we can quickly play with some code.


"
Class {
	#name : #GTPlayground,
	#superclass : #GLMCompositePresentation,
	#category : #'GT-Playground'
}

{ #category : #building }
GTPlayground >> compose [
	self custom:
		(GTInspector new first
			noActions;
			showFirst: [ :a | a custom:
				(GLMWrapper new 
					title: 'Playground';
					show: [:some | 
					some smalltalkCode 
						format: [''];
						selectionPopulate: #selection 
						on: $o 
						entitled: 'Open' 
						with: [ :text | 
							Compiler 
								evaluate: text selectedText 
								for: nil 
								logged: false ] ] ) ];
					yourself) 
]

{ #category : #building }
GTPlayground >> entity [ 
	^ GTPlaygroundPage new content: ''; title: 'Page1'
]
