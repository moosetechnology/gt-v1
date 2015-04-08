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
		'GTPlaygroundEnabledStatus',
		'PreferredExtent',
		'RememberPreferredExtent'
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
		saveContent: aString;
		title: aLabel;
		yourself.
		
	self flag: #TODO. "We need to put an equivalent to the acceptAction thing."
	^ self new openOn: page
]

{ #category : #examples }
GTPlayground class >> examplePlaygroundWithBindings [
	| playground wsBindings |
	wsBindings := Dictionary newFrom: { #number-> 1 }.
	playground := Smalltalk tools workspace
		openContents: 'number + 1'.
	playground
		setBindings: wsBindings.
]

{ #category : #settings }
GTPlayground class >> extentSettingsOn: aBuilder [ 
	<systemsettings>
	
	(aBuilder setting: #GTPlaygroundPreferredWidth)
		target: self;
		parent: #gt;
		getSelector: #preferredWidth;
		setSelector: #preferredWidth:; 
		label: 'Playground width';
		description: 'The preferred width of new Playground windows'.
	(aBuilder setting: #GTPlaygroundPreferredHeight)
		target: self;
		parent: #gt;
		getSelector: #preferredHeight;
		setSelector: #preferredHeight:; 
		label: 'Playground height';
		description: 'The preferred height of new Playground windows'.
	(aBuilder setting: #GTPlaygroundRememberPreferredExtent)
		target: self;
		parent: #gt;
		getSelector: #rememberPreferredExtent;
		setSelector: #rememberPreferredExtent:; 
		label: 'Remember extent of Playground';
		description: 'Enable or disable remembering of the extent of Playground windows on resize. When the preference is true, resizing a Playground window will affect the preferred width and height of future Playground windows'.
	



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
	^ self openOn: page
]

{ #category : #'instance creation' }
GTPlayground class >> openContents: aString [
	"Open a new playground with the given contents. aString has to be Smalltalk code. The style is applied"
	

	| page |
	
	page := GTPlayPage new
		saveContent: aString;
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
		saveContent: aString;
		title: aLabel;
		yourself.
	^ self openOn: page
]

{ #category : #'compatibility-tools' }
GTPlayground class >> openLabel: aLabel [
	| page |

	page := GTPlayPage new
		title: aLabel;
		yourself.
	^ self openOn: page
]

{ #category : #settings }
GTPlayground class >> preferredExtent [
	^ PreferredExtent ifNil: [ PreferredExtent := 600@400 ]
]

{ #category : #settings }
GTPlayground class >> preferredExtent: aPoint [
	PreferredExtent := aPoint
]

{ #category : #settings }
GTPlayground class >> preferredHeight [
	^ self preferredExtent y
]

{ #category : #settings }
GTPlayground class >> preferredHeight: aHeight [
	self preferredExtent setX: self preferredExtent x setY: aHeight
]

{ #category : #settings }
GTPlayground class >> preferredWidth [
	^ self preferredExtent x
]

{ #category : #settings }
GTPlayground class >> preferredWidth: aWidth [
	self preferredExtent setX: aWidth setY: self preferredExtent y
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
GTPlayground class >> rememberPreferredExtent [
	^ RememberPreferredExtent ifNil: [ RememberPreferredExtent := true ]
]

{ #category : #settings }
GTPlayground class >> rememberPreferredExtent: aBoolean [
	^ RememberPreferredExtent := aBoolean
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
GTPlayground class >> setPreferredExtentIfWanted: anExtent [
	self rememberPreferredExtent ifTrue: [ 
		self preferredExtent: anExtent ]
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
		label: 'Local Playground cache directory'.
	(aBuilder setting: #stashDirectory)
		parent: #gt;
		type: #Directory;
		target: GTPlayBook;
		description: 'The path to the local Playground stash that stores all named Playground scripts in ph files' translated;
		label: 'Local Playground stash directory'
]

{ #category : #'tools registry' }
GTPlayground class >> taskbarIcon [
	"Answer the icon for the receiver in a task bar."

	^ Smalltalk ui icons iconNamed: #workspaceIcon
]

{ #category : #'instance creation' }
GTPlayground class >> title [
	^ 'Playground'
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
					text entity saveContent: each content.
					text update ];
				yourself ]
]

{ #category : #building }
GTPlayground >> codeIn: a [
	^ a pharoPlayground
		title: [ :page | 
			GTPlaygroundEditableTabLabel new
				text: page title;
				when: #accepted do: [ :text | 
					page setTitleAndEnsureInStash: text asString ];
				yourself ];
		format: [ :page | page content ];
		act: [ :text :page |
				text selectionInterval: (1 to: text text size).
				text highlightEvaluateAndDo: [ :result | text selection: result ] ]
			icon: GLMUIThemeExtraIcons glamorousGo
			on: $G
			entitled: 'Do it all and go';
		installGoAction;
		installDefaultSelectionActions;
		act: [ :text :page | page publish ]
			icon: ThemeIcons current glamorousSaveToUrl
			entitled: 'Remote publish';
		addAction:
			(GLMPopupAction new
				action: [ :text :page :popup | GTPlaygroundBindingsList new
					on: self currentBindingsSorted;
					when: #bindingRemoved do: [ :binding | self removeBinding: binding ];
					when: #inspect do: [ :binding | binding value inspect ];
					when: #go do: [ :binding | text selection: binding value ];
					yourself ]; 
				icon: ThemeIcons current glamorousTable;
				title: 'Bindings';
				yourself);
		dynamicActions: [ self actionsForPreviousContents ];
		onChangeOfPort: #text act: [ :text :page | page saveContent: text text ]
]

{ #category : #building }
GTPlayground >> compose [
	self title: self defaultPlaygroundTitle.
	self custom:
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
					saveContent: self first panes first presentations first text.
			GTPlayBook instance addPageIfInteresting: self entity ]
]

{ #category : #'accessing-dynamic' }
GTPlayground >> currentBindings [ 

	^ self inspectorPresentation firstPresentation currentBindings
]

{ #category : #'accessing-dynamic' }
GTPlayground >> currentBindingsSorted [

	^ self currentBindings associations asSortedCollection: [ :first :second | first key < second key ]
]

{ #category : #'accessing-defaults' }
GTPlayground >> defaultPlaygroundTitle [
	^ 'Playground'
]

{ #category : #'accessing-dynamic' }
GTPlayground >> inspectorPresentation [

	^ self presentations first 
]

{ #category : #accessing }
GTPlayground >> label: aString [
	"Set the window label to the given string"
	self title: aString.
	self update
]

{ #category : #'scripting opening' }
GTPlayground >> openOn: aPage [
	| window |
	window := super openOn: aPage.
	window extent: self class preferredExtent.
	window when: WindowResizing do: [ 
		(window isMinimized or: [ window isMaximized ]) ifFalse: [ 
			"we only wnat to react to real resizing,
			not to minization or maximization"
			self class setPreferredExtentIfWanted: window extent ] ].
	^ window
]

{ #category : #'accessing-dynamic' }
GTPlayground >> removeBinding: anAssociation [

	|bindings|
	bindings := self currentBindings copy.
	bindings removeKey: anAssociation key ifAbsent: [ ].
	self setBindings: bindings.
]

{ #category : #actions }
GTPlayground >> resetBindings [

	^ self inspectorPresentation firstPresentation resetBindings
]

{ #category : #actions }
GTPlayground >> setBindings: aDictionary [

	self inspectorPresentation firstPresentation 
		variableBindings: [ aDictionary associations ];
		updateVariableBindings
]
