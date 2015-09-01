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
	self title: 'Raw'.
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
		onChangeOfPort: #text act: [ :text :object |
				GTSnippets 
					snippetAt: object class 
					put: (self stringWithoutInitialCommentFrom: text text asString) ];
		installGoAction;
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
	^ (aString trimLeft isEmpty not and: [ aString trimLeft first = $" ])
		ifFalse: [ aString trimBoth ]
		ifTrue: [|startIndex|
			startIndex := aString findAnySubstring: '"' startingAt: (aString indexOf: $") + 1.
			(startIndex = (aString size + 1)) ifTrue: [ "No content if a comment cannot be identified. " ^ '' ].
			(aString
				copyFrom: startIndex + 1 
				to: aString size) trimBoth ]
]

{ #category : #'private building' }
GTObjectVariablesBrowser >> updateInstanceVariable: aSymbol from: anObject basedOn: aString [
	|result|

	(anObject class hasInstVarNamed: aSymbol) 
		ifFalse: [ ^ self ].
	result := anObject class compiler
			source: aString;
			context: nil;
			receiver: anObject;
			failBlock: [ ^ self ];
			evaluate.
						
	anObject writeSlotNamed: aSymbol value: result.
	
]

{ #category : #'private building' }
GTObjectVariablesBrowser >> variableValuePairsFor: anObject [

	^ anObject gtInspectorVariableValuePairs asOrderedCollection 
		yourself
]

{ #category : #'private building' }
GTObjectVariablesBrowser >> variablesIn: composite [
	^ composite table
		showOnly: 50;
		shouldValidate: false;
		allowsRecursiveSearch: false;
		"wantsSteps: true;"
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
			modified: [:newValue :assoc :presentation | 
				self updateInstanceVariable: assoc key from: presentation entity basedOn: newValue.
				presentation update ];
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
