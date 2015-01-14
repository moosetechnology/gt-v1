"
Playground is the correspondent of a classic Smalltalk Workspace. The problem with the name Workspace is that it implies that work should be carried out in this space, while this is not a best practice. Playground describes better the intention of providing a place in which we can quickly play with some code.

The model behind a Playground instance is a PlayPage object.

!!Use cases
The Playground can be used in two ways

# As a place to construct and try out code snippets.
# as an entry point into an inspection process.

In both cases, the ability of diving into objects to the right is an important feature.

!!Running
[ [ [ 
	self open.
 ] ] ]
"
Class {
	#name : #GTPlayground,
	#superclass : #GLMCompositePresentation,
	#classVars : [
		'GTPlaygroundEnabledStatus'
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

	page := GTPlayPage new
		content: aString;
		title: aLabel;
		yourself.
		
	self flag: #TODO. "We need to put an equivalent to the acceptAction thing."
	^ self new openOn: page
]

{ #category : #settings }
GTPlayground class >> isGTPlaygroundEnabled [

	^ GTPlaygroundEnabledStatus ifNil: [ GTPlaygroundEnabledStatus := Smalltalk tools workspace = self ]
]

{ #category : #'instance creation' }
GTPlayground class >> open [
	"self open"
	| page |
	page := GTPlayPage new.
	^ self new openOn: page
]

{ #category : #'instance creation' }
GTPlayground class >> openContents: aString [
	"Open a new playground with the given contents. aString has to be Smalltalk code. The style is applied"
	

	| page |
	
	page := GTPlayPage new
		content: aString;
		yourself.
	^ self new 
		openOn: page;
		yourself
]

{ #category : #'instance creation' }
GTPlayground class >> openContents: aString label: aLabel [
	"Open a new playground with the given contents"

	| page |

	page := GTPlayPage new
		content: aString;
		title: aLabel;
		yourself.
	^ self new openOn: page
]

{ #category : #'compatibility-tools' }
GTPlayground class >> openLabel: aLabel [
	| page |

	page := GTPlayPage new
		title: aLabel;
		yourself.
	^ self new openOn: page
]

{ #category : #'tools registry' }
GTPlayground class >> register [

	self registerToolsOn: Smalltalk tools
]

{ #category : #'tools registry' }
GTPlayground class >> registerToolsOn: registry [
	"Add ourselves to registry. See [Smalltalk tools]"
	"self registerToolsOn: Smalltalk tools" 
	registry register: self as: #workspace

]

{ #category : #settings }
GTPlayground class >> setGTPlaygroundEnabledStatus: aBoolean [
	| oldStatus |
	
	oldStatus := self isGTPlaygroundEnabled.
	GTPlaygroundEnabledStatus := aBoolean.
	oldStatus ~= GTPlaygroundEnabledStatus ifTrue: [ 
		GTPlaygroundEnabledStatus 
			ifTrue: [ self register ]
			ifFalse: [ Workspace registerToolsOn: Smalltalk tools ] ]
	
	
]

{ #category : #settings }
GTPlayground class >> settingsOn: aBuilder [ 
	<systemsettings>
	
	(aBuilder setting: #GTPlaygroundStatus)
		target: self;
		parent: #gt;
		getSelector: #isGTPlaygroundEnabled;
		setSelector: #setGTPlaygroundEnabledStatus:; 
		label: 'GTPlayground';
		description: 'Enable or disable the GTPlayground.'.
	(aBuilder setting: #cacheDirectory)
		parent: #gt;
		type: #Directory;
		target: GTPlayBook;
		description: 'The path to the local Playground cache that stores all Playground scripts in ph files' translated;
		label: 'Local Playground cache directory'

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
	^ GTPlayBook instance pages
		collect: [ :each | 
			GLMGenericAction new
				title: (each content asString contractTo: 50);
				action: [ :text | 
					text entity content: each content.
					text update ];
				yourself ]
]

{ #category : #building }
GTPlayground >> codeIn: a [
	^ a pharoPlayground
		title: [ :page | page title ];
		format: [ :page | page content ];
		act: [ :text :page |
				text selectionInterval: (1 to: text text size).
				text highlightEvaluateAndDo: [ :result | text selection: result ] ]
			icon: GLMUIThemeExtraIcons glamorousGo
"			on: $G"
			entitled: 'Do it all and go';
		installGoAction;
		installDefaultSelectionActions;
		act: [ :text :page | page publishUrl ]
			icon: GLMUIThemeExtraIcons glamorousSaveToUrl
			entitled: 'Remote publish';
		dynamicActions: [ self actionsForPreviousContents ];
		onChangeOfPort: #text act: [ :text :page | page content: text text ]
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
			GTPlayBook instance addPageIfInteresting: self entity ]
]

{ #category : #'as yet unclassified' }
GTPlayground >> label: aString [
	"Set the window label to the given string"
	self title: aString.
	self update
]
