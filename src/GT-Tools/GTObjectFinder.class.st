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
	browser composite: [:a |
		a title: [ :anObject | self printObjectAsAnItem: anObject ].
		a list
			title: 'Variables';	
			display: 
				[ :anObject | 
				anObject class allInstVarNames collect: [ :iv | iv -> (anObject instVarNamed: iv) ] ];
			format: [ :assoc | assoc key asString , ' : ' , (assoc value printString copyFrom: 1 to: ((50 min: assoc value printString size) max: 0)) ];
			send: #value.
		a list
			title: 'Items';
			when: [ :each | each isCollection ];
			showOnly: 20.
		a text
			forSmalltalk;
			display: [ :entity | 'self' ];
			title: 'Evaluator';
			populate: #selection
				on: $o
				entitled: 'Open (o)'
				with: 
					[ :text :entity | 
					Compiler 
						evaluate: text selectedText
						for: entity
						logged: false ];
			act: [ :text :entity | (Compiler 
									evaluate: text selectedText
									for: entity
									logged: false) inspect ]
				on: $/
				entitled: 'Inspect (/)'.
	].
	^ browser
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
