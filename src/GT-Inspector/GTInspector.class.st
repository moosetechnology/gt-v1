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
	#superclass : #GLMBrowserTemplate,
	#classVars : [
		'GTNumberOfInspectorPanes'
	],
	#category : #'GT-Inspector'
}

{ #category : #'class initialization' }
GTInspector class >> initialize [ 
	self numberOfInspectorPanes: 2
]

{ #category : #settings }
GTInspector class >> numberOfInspectorPanes [
	^ GTNumberOfInspectorPanes 
]

{ #category : #settings }
GTInspector class >> numberOfInspectorPanes: anInteger [
	GTNumberOfInspectorPanes := anInteger 
]

{ #category : #'tools registry' }
GTInspector class >> registerToolsOn: registry [
	"self registerToolsOn: Smalltalk tools " 
	registry register: self as: #objectExplorer

]

{ #category : #settings }
GTInspector class >> settingsOn: aBuilder [ 
	<systemsettings>
	
	(aBuilder group: #glamorousInspector)
		label: 'Glamorous Inspector';
"		parent: #glamorousToolkit"
		with: [
			(aBuilder setting: #numberOfInspectorPanes)
				target: self; 
				label: 'Number of inspector panes';
		 		description: 'Specifies the maximum number of panes that are visible at every moment in a Glamorous Inspector.'.]
]

{ #category : #building }
GTInspector >> buildBrowser [
	browser := GLMFinder new.
	browser fixedSizePanes: self class numberOfInspectorPanes.
	browser title: [:anObject | 'Inspector on ', (self printObjectAsAnItem: anObject)].
	browser act: [:b | b update] icon: GLMUIThemeExtraIcons glamorousRefresh entitled: 'Update'.
	browser show: [ :a | 
		a title: [ :anObject | self printObjectAsAnItem: anObject ].
		a 
			morphicAct: [:composite | composite entity browse]
			icon: GLMUIThemeExtraIcons glamorousBrowse 
			entitled: 'Browse'.
		a dynamic 
			display: [:each | 
				| dynamic |
				dynamic := GLMCompositePresentation new.
				each gtInspectorPresentationsIn: dynamic.
				dynamic ] ].
	^ browser
]

{ #category : #opening }
GTInspector >> openExplorerFor: anObject [
	"this method is needed for compatibility with ObjectExplorer"
	self openOn: anObject
]

{ #category : #private }
GTInspector >> printObjectAsAnItem: anObject [ 
	| title stream previewString |
	stream := String new writeStream.
	title := anObject class name.
	stream
		nextPutAll: (title first isVowel 
				ifTrue: [ 'an ' ]
				ifFalse: [ 'a ' ]);
		nextPutAll: title.
	previewString := [ Text fromString: (anObject printString contractTo: 10) ]
						on: Error
						do: [ 'error printing' ].
	stream 
		nextPutAll: ' (';
		nextPutAll: previewString;
		nextPut: $).
	^ stream contents
]
