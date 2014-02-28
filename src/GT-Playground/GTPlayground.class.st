"
self open.
self reset.

Playground is the correspondent of a classic Smalltalk Workspace. The problem with the name Workspace is that it implies that work should be carried out in this space, while this is not a best practice. Playground describes better the intention of providing a place in which we can quickly play with some code.

self registerToolsOn: Smalltalk tools

"
Class {
	#name : #GTPlayground,
	#superclass : #GLMCompositePresentation,
	#instVars : [
		'context'
	],
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

{ #category : #'tools registry' }
GTPlayground class >> taskbarIcon [
	"Answer the icon for the receiver in a task bar."

	^ Smalltalk ui icons iconNamed: #workspaceIcon
]

{ #category : #building }
GTPlayground >> actionsForPreviousContents [
	^ self class repository reverse
		collect: [ :each | 
			GLMGenericAction new
				title: (each content asString contractTo: 50);
				action: [ :text | 
					self pushToRepositoryFrom: text.
					text entity: each.
					self class repository remove: each.
					text update ];
				yourself ]
]

{ #category : #building }
GTPlayground >> codeIn: a [
	^ a smalltalkCode
		title: [ :page | page title ];
		format: [ :page | page content ];
		variableBindings: [ :page| context bingings ];
		selectionPopulate: #selection
			on: $o
			entitled: 'Open'
			with: [ :text :page |
				text selectLine.
				page content: text text.
				self evaluateSelectionFrom: text ];
		dynamicActions: [ self actionsForPreviousContents ]
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

{ #category : #building }
GTPlayground >> evaluateSelectionFrom: aTextPresentation [
	| result |
	
	aTextPresentation selectLine.
	context notifier: aTextPresentation. "In case of a compilation error this object get's notified."
	result := self evaluateText: aTextPresentation selectedText notifying: context.
	context notifier: nil. 
	aTextPresentation updateVariableBindings.
	^ result
]

{ #category : #'do-its' }
GTPlayground >> evaluateText: aText notifying: aRequestor [
	|result|
	
	"Must evaluate with context and receiver nil so that the missing bingings get created"
	result := nil class compiler
		source: aText;
		context: nil;
		receiver: nil;
		requestor: aRequestor;
		failBlock:  [ ^ nil];
		evaluate.	
	^ result

]

{ #category : #initializing }
GTPlayground >> initialize [

	super initialize.
	context := GTPlaygroundContext new
]

{ #category : #building }
GTPlayground >> pushToRepositoryFrom: aTextPresentation [
	| page |
	page := GTPlaygroundPage new.
	page content: aTextPresentation text.
	page content asString trimBoth isEmpty
		ifFalse: [ self class repository add: page ] 
]
