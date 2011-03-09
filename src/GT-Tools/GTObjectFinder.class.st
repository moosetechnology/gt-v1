"
This is meant to be used for inspecting objects. It offers multiple views and it uses a finder as a navigation. One feature particular feature is that one can use the evaluator tab to enter code, and evaluating it results in opening another pane to the right.

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

{ #category : #building }
GTObjectFinder >> evaluatorIn: a [
	^ (a text)
		forSmalltalk;
		display: [ :entity | 'self' ];
		title: 'Evaluator';
		selectionPopulate: #selection
			on: $o
			entitled: 'Open (o)'
			with: [ :text :entity | Compiler evaluate: text selectedText for: entity logged: false ];
		selectionAct: [ :text :entity | (Compiler evaluate: text selectedText for: entity logged: false) inspect ]
			on: $/
			entitled: 'Inspect (/)'
]

{ #category : #building }
GTObjectFinder >> itemsIn: a [
	(a list)
		title: [ :anObject | anObject size asString , ' items' ];
		when: [ :each | each isCollection ];
		icon: [ :each |  OBMorphicIcons iconNamed: each class theNonMetaClass browserIcon ];
		showOnly: 20
]

{ #category : #private }
GTObjectFinder >> methodsBrowser [
	| methodsBrowser |
	methodsBrowser := GLMTabulator new.
	methodsBrowser title: 'Methods'.
	methodsBrowser row: #methods; row: #source.
	methodsBrowser transmit to: #methods; andShow: [:a | 
		a list 
			display: [:object | object class methods ];
			format: [:method | method selector];
			selectionPopulate: #evaluatedObject on: $o entitled: 'Evaluate and open' with: [:list :object | object perform: list selection selector ] ].
	methodsBrowser transmit to: #source; from: #methods; andShow: [:a | 
		a text 
			display: [:method | method getSource ];
			forSmalltalk: [:method | method methodClass ]].
	methodsBrowser transmit toOutside: #selection; from: #methods port: #evaluatedObject.
	^ methodsBrowser 
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

{ #category : #building }
GTObjectFinder >> variablesIn: a [
	(a list)
		title: 'Variables';
		display: [ :anObject | 
			OrderedCollection new 
				add: ('self' -> anObject);
				addAll: (anObject class allInstVarNames collect: [ :iv | iv -> (anObject instVarNamed: iv)]);
				yourself
			 ];
		format: [ :assoc | assoc key asString , ' : ' , (assoc value printString copyFrom: 1 to: ((50 min: assoc value printString size) max: 0)) ];
		icon: [ :each |  OBMorphicIcons iconNamed: each value class theNonMetaClass browserIcon ];
		send: #value
]
