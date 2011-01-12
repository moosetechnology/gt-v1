"
self openOn: MooseModel root
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
	browser
		composite: [ :a | 
			a title: [ :anObject | self printObjectAsAnItem: anObject ].
			self variablesIn: a.
			self itemsIn: a.
			self evaluatorIn: a ].
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

{ #category : #building }
GTObjectFinder >> methodsBrowser [
	 | b | 
	b := GLMTabulator new.
	b column: #hierarchy; column: #methods.
	b transmit to: #hierarchy; andShow: [ :a | 
		a list 
			display: [ :anObject | anObject class withAllSuperclasses ] ].
	^ b
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
		display: [ :anObject | anObject class allInstVarNames collect: [ :iv | iv -> (anObject instVarNamed: iv) ] ];
		format: [ :assoc | assoc key asString , ' : ' , (assoc value printString copyFrom: 1 to: ((50 min: assoc value printString size) max: 0)) ];
		icon: [ :each |  OBMorphicIcons iconNamed: each value class theNonMetaClass browserIcon ];
		send: #value
]
