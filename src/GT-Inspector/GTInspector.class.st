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
GTInspector class >> registerToolsOn: registry [
	"self registerToolsOn: Smalltalk tools " 
	registry register: self as: #inspector

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
		 		description: 'Specifies the maximum number of panes that are visible at every moment in a Glamorous Inspector.'.]
]

{ #category : #building }
GTInspector >> compose [
	self title: [:anObject | 'Inspector on ', (self printObjectAsAnItem: anObject)].
	self act: [:b | b update] icon: GLMUIThemeExtraIcons glamorousRefresh entitled: 'Update'.
	self pager with: [ :browser | 
		browser fixedSizePanes: self class numberOfInspectorPanes.
		browser show: [ :a :each |
			a title: [ self printObjectAsAnItem: each ].
			a dynamicActions: [ each gtInspectorActions ].
			a dynamic display: [ :x | 
				(GLMCompositePresentation new with: [:d | 
					each 
						gtInspectorPresentationsIn: d 
						inContext: self ])
						startOn: x ] ] ]
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

{ #category : #private }
GTInspector >> printObjectAsAnItem: anObject [ 
	|  stream  |
	stream := String new writeStream.
	stream
		nextPutAll: (anObject class name first isVowel 
				ifTrue: [ 'an ' ]
				ifFalse: [ 'a ' ]);
		nextPutAll: anObject class name.
	stream 
		nextPutAll: ' (';
		nextPutAll: (GTObjectPrinter new asTruncatedTextFrom: anObject) asString;
		nextPut: $).
	^ stream contents
]
