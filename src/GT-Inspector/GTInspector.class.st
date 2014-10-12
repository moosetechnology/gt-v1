"
This is meant to be used for inspecting objects. It offers multiple views and it uses a finder as a navigation. One particular feature is that you can use the evaluator tab to enter code, and evaluating it results in opening another pane to the right.

The object finder asks dynamically the object for the actual presentations that are displayed in each pane.

Example:
self openOn: Smalltalk.

Register it as a replacement for explorer:
self registerToolsOn: Smalltalk tools.
"
Class {
	#name : #GTInspector,
	#superclass : #GLMCompositePresentation,
	#classVars : [
		'GTInspectorEnabledStatus',
		'GTNumberOfInspectorPanes'
	],
	#category : #'GT-Inspector'
}

{ #category : #openning }
GTInspector class >> explore: anObject [ 
	self openOn: anObject.
	^ anObject
]

{ #category : #inspecting }
GTInspector class >> gtInspectorExtensionsIn: composite [
	<gtInspectorPresentationOrder: 40>
	composite list
		title: 'Extensions';
		display: [ self inspectorExtendingMethods ];
		showOnly: 50;
		format: [ :each | each gtDisplayString ];
		filterOn: [ :text :each | each gtDisplayString includesSubstring: text caseSensitive: false ]
]

{ #category : #'class initialization' }
GTInspector class >> initialize [ 
	self numberOfInspectorPanes: 2
]

{ #category : #openning }
GTInspector class >> inspect: anObject [ 
	self openOn: anObject.
	^ anObject
]

{ #category : #openning }
GTInspector class >> inspect: anObject label: aString [
	self new 
		title: aString;
		openOn: anObject.
	^ anObject

]

{ #category : #openning }
GTInspector class >> inspector: anObject [

	^ self inspect: anObject
]

{ #category : #inspecting }
GTInspector class >> inspectorExtendingMethods [
	^ (Object withAllSubclasses
		flatCollect: [ :each | 
			(Pragma allNamed: #gtInspectorPresentationOrder: in: each) 
				collect: [ :p | p method asRingDefinition ] ])
		sorted
]

{ #category : #settings }
GTInspector class >> isGTInspectorEnabled [

	^ GTInspectorEnabledStatus ifNil: [ GTInspectorEnabledStatus := Smalltalk tools inspector = self ]
]

{ #category : #settings }
GTInspector class >> numberOfInspectorPanes [
	^ GTNumberOfInspectorPanes 
]

{ #category : #settings }
GTInspector class >> numberOfInspectorPanes: anInteger [
	GTNumberOfInspectorPanes := anInteger 
]

{ #category : #openning }
GTInspector class >> openOn: anObject [ 
	^ self new openOn: anObject
]

{ #category : #'tools registry' }
GTInspector class >> register [

	self registerToolsOn: Smalltalk tools

]

{ #category : #'tools registry' }
GTInspector class >> registerToolsOn: registry [
	"self registerToolsOn: Smalltalk tools " 
	registry register: self as: #inspector

]

{ #category : #settings }
GTInspector class >> setGTInspectorEnabledStatus: aBoolean [
	| oldStatus |
	
	oldStatus := self isGTInspectorEnabled.
	GTInspectorEnabledStatus := aBoolean.
	oldStatus ~= GTInspectorEnabledStatus ifTrue: [ 
		GTInspectorEnabledStatus 
			ifTrue: [ self register ]
			ifFalse: [ EyeInspector registerToolsOn: Smalltalk tools ] ]
	
	
]

{ #category : #settings }
GTInspector class >> settingsOn: aBuilder [ 
	<systemsettings>
	
	(aBuilder group: #gt)
		label: 'Glamorous Toolkit';
		with: [
			(aBuilder setting: #numberOfInspectorPanes)
				target: self; 
				label: 'Number of inspector panes';
		 		description: 'Specifies the maximum number of panes that are visible at every moment in a Glamorous Inspector.'.
			(aBuilder setting: #GTInspectorStatus)
				target: self;
				getSelector: #isGTInspectorEnabled;
				setSelector: #setGTInspectorEnabledStatus:; 
				label: 'GTInspector';
		 		description: 'Enable or disable the GTInspector.'.]
]

{ #category : #'as yet unclassified' }
GTInspector >> actOnPaneAdded: ann [

	self panes size > 1 ifTrue: [ 
		(self panes before: self panes last) updateToolbar "announce: (GLMPresentationToolbarUpdated new presentation: ann presentation)" ]
]

{ #category : #'as yet unclassified' }
GTInspector >> closeActionFor: aPresentation [

	^ GLMGenericAction new
			action: [ self removeLastPane ];
			icon: GLMUIThemeExtraIcons glamorousCancel ;
			condition: [ :currentPresentation |
				self panes size > 1 and: [ self panes last presentations = currentPresentation ] ];
			title: 'Close' 
]

{ #category : #building }
GTInspector >> compose [
	self title: [:anObject | 'Inspector on ', (self printObjectAsAnItem: anObject)].
	self act: [:b | b update] icon: GLMUIThemeExtraIcons glamorousRefresh entitled: 'Update'.
	self pager with: [ :browser | 
		browser fixedSizePanes: self class numberOfInspectorPanes.
		browser show: [ :a :each |
			a title: [ self printObjectAsAnItem: each ].
			a dynamicActions: [ :aPresentation | 
				each gtInspectorActions asOrderedCollection ].
			a titleAction: [ :aPresentation | self closeActionFor: aPresentation ].
			a dynamic 
				display: [ :x | 
					(GLMCompositePresentation new with: [:d | 
						each 
							gtInspectorPresentationsIn: d 
							inContext: self ])
							startOn: x ] ] ].
			
	self first on: GLMPaneAdded send: #actOnPaneAdded: to: self
]

{ #category : #accessing }
GTInspector >> entities [
	"returns the list of objects from the #entity port of each pane of the finder"
	^ self first panes collect: [ :each | 
		(each port: #entity) value ]
]

{ #category : #opening }
GTInspector >> openExplorerFor: anObject [
	"this method is needed for compatibility with ObjectExplorer"
	self openOn: anObject
]

{ #category : #accessing }
GTInspector >> panes [
	^ self first panes
]

{ #category : #accessing }
GTInspector >> previousEntity [
	^ self entities reverse second
]

{ #category : #accessing }
GTInspector >> previousEntityTo: anObject [
	| entities index |
	entities := self entities.
	index := entities indexOf: anObject.
	^ index < 2 
		ifTrue: [ nil ]
		ifFalse: [ entities at: index - 1 ]
]

{ #category : #private }
GTInspector >> printObjectAsAnItem: anObject [
	| header printString |
	header := (anObject class name first isVowel
		ifTrue: [ 'an ' ]
		ifFalse: [ 'a ' ]) , anObject class name.
	printString := (GTObjectPrinter new asTruncatedTextFrom: anObject) asString.
	^ (printString beginsWith: header)
		ifTrue: [ printString ]
		ifFalse: [ 
			String streamContents: [ :out | 
				out << header; << ' ('; << printString; << ')' ] ]
]

{ #category : #'as yet unclassified' }
GTInspector >> removeLastPane [
	| lastPane |
	
	lastPane := self first panes last.
	self first removeLastPane.
	self first announce: (GLMPaneRemoved pane: lastPane fromBrowser: self first).
	self first panes last updateToolbar
]

{ #category : #'as yet unclassified' }
GTInspector >> showFirst: aBlock [

	self first showFirst: aBlock
]
