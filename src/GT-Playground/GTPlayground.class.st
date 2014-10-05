"
self open.
self reset.

Playground is the correspondent of a classic Smalltalk Workspace. The problem with the name Workspace is that it implies that work should be carried out in this space, while this is not a best practice. Playground describes better the intention of providing a place in which we can quickly play with some code.

self registerToolsOn: Smalltalk tools

"
Class {
	#name : #GTPlayground,
	#superclass : #GLMCompositePresentation,
	#classVars : [
		'GTPlaygroundEnabledStatus'
	],
	#classInstVars : [
		'repository'
	],
	#category : #'GT-Playground'
}

{ #category : #'compatibility-tools' }
GTPlayground class >> edit: aString label: aLabel [

"Open a new playground with the given contents"
"Compatibility with the original Workspace"
"#edit: aText label: labelString accept: anAction"
"	^(Smalltalk tools workspace openLabel: labelString)
		acceptContents:  aText;
		acceptAction: anAction;
		yourself."

"Open an editor on the given string/text"
	| page |
	"self halt"

	page := GTPlaygroundPage new
		content: aString;
		title: aLabel;
		yourself.
		
	self flag: #TODO. "We need to put an equivalent to the acceptAction thing."
	^ self new openOn: page
]

{ #category : #'as yet unclassified' }
GTPlayground class >> isGTPlaygroundEnabled [

	^ GTPlaygroundEnabledStatus ifNil: [ GTPlaygroundEnabledStatus := Smalltalk tools workspace = self ]
]

{ #category : #'instance creation' }
GTPlayground class >> open [
	"self open"
	| page |
	page := GTPlaygroundPage new.
	^ self new openOn: page
]

{ #category : #'instance creation' }
GTPlayground class >> openContents: aString [
	"Open a new playground with the given contents. aString has to be Smalltalk code. The style is applied"
	

	| page |
	
	page := GTPlaygroundPage new
		content: aString;
		yourself.
	^ self new openOn: page
]

{ #category : #'instance creation' }
GTPlayground class >> openContents: aString label: aLabel [
	"Open a new playground with the given contents"

	| page |

	page := GTPlaygroundPage new
		content: aString;
		title: aLabel;
		yourself.
	^ self new openOn: page
]

{ #category : #'compatibility-tools' }
GTPlayground class >> openLabel: aLabel [
	| page |

	page := GTPlaygroundPage new
		title: aLabel;
		yourself.
	^ self new openOn: page
]

{ #category : #'as yet unclassified' }
GTPlayground class >> register [

	self registerToolsOn: Smalltalk tools
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

{ #category : #'as yet unclassified' }
GTPlayground class >> setGTPlaygroundEnabledStatus: aBoolean [
	| oldStatus |
	
	oldStatus := self isGTPlaygroundEnabled.
	GTPlaygroundEnabledStatus := aBoolean.
	oldStatus ~= GTPlaygroundEnabledStatus ifTrue: [ 
		GTPlaygroundEnabledStatus 
			ifTrue: [ self register ]
			ifFalse: [ Workspace registerToolsOn: Smalltalk tools ] ]
	
	
]

{ #category : #'as yet unclassified' }
GTPlayground class >> settingsOn: aBuilder [ 
	<systemsettings>
	
	(aBuilder setting: #GTPlaygroundStatus)
		target: self;
		parent: #gt;
		getSelector: #isGTPlaygroundEnabled;
		setSelector: #setGTPlaygroundEnabledStatus:; 
		label: 'GTPlayground';
		description: 'Enable or disable the GTPlayground.'
]

{ #category : #'tools registry' }
GTPlayground class >> taskbarIcon [
	"Answer the icon for the receiver in a task bar."

	^ Smalltalk ui icons iconNamed: #workspaceIcon
]

{ #category : #accessing }
GTPlayground >> acceptAction: anAction [
	"acceptAction := anAction."
]

{ #category : #accessing }
GTPlayground >> acceptContents: aString [

	^ (self entity acceptContents: aString)
		ifTrue: [  
			self update.
			true]
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
	^ a pharoPlayground
		title: [ :page | page title ];
		format: [ :page | page content ];
		act: [ :text :page |
				page content: text text.
				text selectionInterval: (1 to: text text size).
				text evaluateSelectionAndDo: [ :result | text selection: result ]  ]
			icon: GLMUIThemeExtraIcons glamorousPlay
"			on: $G"
			entitled: 'Do it all and go';
		selectionAct: [ :text :page |
				page content: text text.
				text evaluateSelectionAndDo: [ :result | text selection: result ] ]
			on: $g
			entitled: 'Do it and go';
		installDefaultSelectionActions;
		dynamicActions: [ self actionsForPreviousContents ]
]

{ #category : #building }
GTPlayground >> compose [
	self
		title: 'Playground';
		custom:
			(GTInspector new
				noTitle; 
				noActions;
				showFirst: [ :composite |
					self codeIn: composite ];
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
GTPlayground >> pushToRepositoryFrom: aTextPresentation [
	| page |
	page := GTPlaygroundPage new.
	page content: aTextPresentation text.
	page content asString trimBoth isEmpty
		ifFalse: [ self class repository add: page ] 
]
