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
		browser transmit from: #variables; toOutsidePort: #selection; transformed: [:assoc | assoc ifNotNil: [assoc value]].
		browser transmit from: #evaluator; toOutsidePort: #selection ]
]

{ #category : #'private building' }
GTObjectVariablesBrowser >> evaluatorIn: composite [
	^ composite pharoPlayground
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
			on: $g
			entitled: 'Do it and go';
		installDefaultSelectionActions
]

{ #category : #'private building' }
GTObjectVariablesBrowser >> iconFor: anObject [
		
	^ [ (anObject iconOrThumbnailOfSize: 16)
		ifNil: [ anObject class systemIcon ] ]
			on: Error do: [ :error |
			self iconFor: anObject error: error ]
]

{ #category : #'private building' }
GTObjectVariablesBrowser >> iconFor: anEyeElement error: error [
	^ Smalltalk ui icons smallWarningIcon
]

{ #category : #'private building' }
GTObjectVariablesBrowser >> printStringOf: anObject [
	^ [(anObject printString contractTo: 200) asComment] 
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
		yourself
]

{ #category : #'private building' }
GTObjectVariablesBrowser >> variablesIn: composite [
	^ composite table
		showOnly: 50;
		shouldValidate: false;
		children: [ :assoc | assoc key = 'self'
			ifTrue: [ #() ]
			ifFalse: [ self variableValuePairsFor: assoc value ] ];
		icon: [ :assoc | self iconFor: assoc value ];
		display: [ :anObject | (self variableValuePairsFor: anObject)
				addFirst: 'self' -> anObject;
				yourself ];
		column: 'Variable' 
			evaluated: [:assoc | '  ',(GTObjectPrinter new asNonTruncatedTextFrom: assoc key) ];
		column: 'Value' 
			evaluated: [:assoc | GTObjectPrinter new asTruncatedTextFrom: assoc value ]
			"modified: [:newValue | self flag: 'change variable value here' ]";
		"send: #value;"
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
