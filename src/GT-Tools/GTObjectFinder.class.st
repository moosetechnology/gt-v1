"
This is meant to be used for inspecting objects. It offers multiple views and it uses a finder as a navigation. One feature particular feature is that one can use the evaluator tab to enter code, and evaluating it results in opening another pane to the right.

The object finder asks dynamically the object for the actual presentations that are displayed in each pane.

self openOn: Smalltalk.
"
Class {
	#name : #GTObjectFinder,
	#superclass : #GLMBrowserTemplate,
	#category : #'GT-Tools'
}

{ #category : #building }
GTObjectFinder >> buildBrowser [
	browser := GLMFinder new.
	browser title: [:anObject | (self printObjectAsAnItem: anObject), ' - Object Finder'].
	browser show: [ :a | 
		a title: [ :anObject | self printObjectAsAnItem: anObject ].
		a morphicAct: [:composite | composite entity browse] icon: GLMUIThemeExtraIcons glamorousBrowse entitled: 'Browse'.
		a dynamic 
			display: [:each | 
				| dynamic |
				dynamic := GLMCompositePresentation new.
				each objectFinderPresentationsIn: dynamic.
				dynamic ] 		
		"self variablesIn: a.
		self itemsIn: a.
		a custom: self methodsBrowser.
		self evaluatorIn: a "].
	^ browser
]

{ #category : #private }
GTObjectFinder >> printObjectAsAnItem: anObject [ 
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
