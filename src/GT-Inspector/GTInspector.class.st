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
	#category : #'GT-Inspector'
}

{ #category : #'tools registry' }
GTInspector class >> registerToolsOn: registry [
	"self registerToolsOn: Smalltalk tools " 
	registry register: self as: #objectExplorer

]

{ #category : #building }
GTInspector >> buildBrowser [
	browser := GLMFinder new.
	browser title: [:anObject | (self printObjectAsAnItem: anObject), ' - Inspector'].
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
	| title stream |
	stream := String new writeStream.
	title := anObject class name.
	stream
		nextPutAll: (title first isVowel 
				ifTrue: [ 'an ' ]
				ifFalse: [ 'a ' ]);
		nextPutAll: title.
	^ stream contents
]
