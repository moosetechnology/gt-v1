"
This is a helper browser for the main view in the GTInspector.

Example:
self openOn: Smalltalk
"
Class {
	#name : #GTObjectVariablesBrowser,
	#superclass : #GLMCompositePresentation,
	#category : #'GT-Inspector'
}

{ #category : #building }
GTObjectVariablesBrowser >> compose [
	self title: 'State'.
	self tabulator with: [ :browser |
		browser row: #variables; row: #evaluator.
		browser transmit to: #variables; andShow: [:a | 
			self variablesIn: a ].
		browser transmit to: #evaluator; andShow: [:a | 
			self evaluatorIn: a ].
		browser transmit from: #variables; toOutsidePort: #selection.
		browser transmit from: #evaluator; toOutsidePort: #selection ]
]

{ #category : #'private building' }
GTObjectVariablesBrowser >> evaluatorIn: composite [
	^ (composite smalltalkCode)
		beForScripting;
		doItReceiver: #yourself;
		display: [ :object | 
			String streamContents: [ :stream | 
				stream 
					nextPutAll: (self printStringOf: object);
					cr;
					nextPutAll: (GTSnippets snippetAt: object class)] ];
		selectionAct: [ :text :object |
				GTSnippets snippetAt: object class put: (self stringWithoutInitialCommentFrom: text text asString).
				text evaluateSelectionAndDo: [ :result | text selection: result ] ]
			on: $o
			entitled: 'Do it and open (o)';
		installDefaultSelectionActions
]

{ #category : #'private building' }
GTObjectVariablesBrowser >> printStringOf: anObject [
	^ [(anObject printString contractTo: 200) asSmalltalkComment] 
			on: Error 
			do: ['"Error printing. Try self printString to debug"']
]

{ #category : #'private building' }
GTObjectVariablesBrowser >> stringWithoutInitialCommentFrom: aString [
	^ aString first = $" 
		ifFalse: [ aString trimBoth ]
		ifTrue: [ 
			(aString
				copyFrom: (aString findAnySubStr: '"' startingAt: 2) + 1 
				to: aString size) trimBoth ]
]

{ #category : #'private building' }
GTObjectVariablesBrowser >> variableValuePairsFor: anObject [
	^ anObject gtInspectorVariableValuePairs asSortedCollection asOrderedCollection 
		addFirst: 'self' -> anObject; 
		yourself
]

{ #category : #'private building' }
GTObjectVariablesBrowser >> variablesIn: composite [
	^ composite table
		showOnly: 50;
		display: [ :anObject | self variableValuePairsFor: anObject ];
		column: 'Variable' 
			evaluated: [:assoc | GTObjectPrinter new asNonTruncatedTextFrom: assoc key ] 
			sortedBy: [ :x :y | x > y ];
		column: 'Value' 
			evaluated: [:assoc | GTObjectPrinter new asTruncatedTextFrom: assoc value ]
			sortedBy: [ :x :y | x > y ];
		send: #value;
		morphicSelectionAct: [:list | list selection value browse ] 
			icon: GLMUIThemeExtraIcons glamorousBrowse 
			on: $b 
			entitled: 'Browse';
		morphicSelectionAct: [:list | list selection value inspect ] 
			icon: GLMUIThemeExtraIcons glamorousInspect 
			on: $i 
			entitled: 'Inspect';
		selectionAct: [:list | 
			((list selection pointersToExcept: { list selection })
									reject: [ :each | each pointsOnlyWeaklyTo: list selection ]) inspect ] 
			on: $t
			entitled: 'Open pointers to'
]
