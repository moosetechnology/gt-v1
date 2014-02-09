"
self open.


Playground is the correspondent of a classic Smalltalk Workspace. The problem with the name Workspace is that it implies that work should be carried out in this space, while this is not a best practice. Playground describes better the intention of providing a place in which we can quickly play with some code.


"
Class {
	#name : #GTPlayground,
	#superclass : #GLMCompositePresentation,
	#classInstVars : [
		'repository'
	],
	#category : #'GT-Playground'
}

{ #category : #'instance creation' }
GTPlayground class >> open [
	"self open"
	| page |
	page := GTPlaygroundPage new.
	^ self new openOn: page
]

{ #category : #'tools registry' }
GTPlayground class >> registerToolsOn: registry [
	"Add ourselves to registry. See [Smalltalk tools]"
	"self registerToolsOn: Smalltalk tools" 
	registry register: self as: #workspace

]

{ #category : #accessing }
GTPlayground class >> repository [
	^ repository ifNil: [ repository := OrderedCollection new ]
]

{ #category : #accessing }
GTPlayground class >> reset [
	repository := nil
]

{ #category : #building }
GTPlayground >> codeIn: a [
	^ a smalltalkCode
		format: [ :page | page content ];
		selectionPopulate: #selection
			on: $o
			entitled: 'Open'
			with: [ :text :page | 
				page content: text text.
				Compiler 
					evaluate: text selectedText 
					for: nil 
					logged: false ];
		title: [ :page | page title ];
		dynamicActions: [ 
			self class repository
				collect: [ :each | 
					GLMGenericAction new
						title: (each content asString contractTo: 50);
						action: [ :text | text text: each content asString ];
						yourself ] ]
]

{ #category : #building }
GTPlayground >> compose [
	self
		title: 'Playground';
		custom:
			(GTInspector new first
				noActions;
				showFirst: [ :a | self codeIn: a ];
				yourself);
		on: GLMBrowserClosing do: [ 
			"This is a hack for the moment.
			We need a better mechanism from Glamour to help 
			us keep the model in sync"
			self entity
					content: self first panes first presentations first text.
			self entity content asString trimBoth isEmpty
				ifFalse: [ self class repository add: self entity ] ]
]
