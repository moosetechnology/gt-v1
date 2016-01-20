"
This is a helper browser for the Raw view in the GTInspector. It provides an overview of the slots and it offers an evaluator.
"
Class {
	#name : #GTRawObjectVariablesBrowser,
	#superclass : #GLMCompositePresentation,
	#category : #'GT-Inspector'
}

{ #category : #building }
GTRawObjectVariablesBrowser >> compose [
	self title: 'Raw'.
	self tabulator with: [ :browser |
		browser row: #variables; row: #evaluator.
		browser transmit 
			to: #variables; 
			andShow: [:a | self variablesIn: a ].
		browser transmit 
			to: #evaluator; 
			andShow: [:a | self evaluatorIn: a ].
		browser transmit 
			from: #variables; 
			toOutsidePort: #selection; 
			transformed: [:assoc | assoc ifNotNil: [assoc value]].
		browser transmit 
			from: #evaluator; 
			toOutsidePort: #selection ]
]

{ #category : #'private building' }
GTRawObjectVariablesBrowser >> evaluatorIn: composite [
	^ composite pharoScript
		doItReceiver: [:x | x ];
		display: [ :object | 
			String streamContents: [ :stream | 
				stream 
					nextPutAll: (self printStringOf: object);
					cr;
					nextPutAll: (GTSnippets snippetAt: object class)] ];
		onChangeOfPort: #text act: [ :textPresentation :object |
				GTSnippets 
					snippetAt: object class 
					put: (self stringWithoutInitialCommentFrom: textPresentation text asString).
				 textPresentation clearUserEdits ];
		installDefaultSelectionActions
]

{ #category : #'private building' }
GTRawObjectVariablesBrowser >> iconFor: anObject [
		
	^ [ (anObject iconOrThumbnailOfSize: 16)
		ifNil: [ anObject class systemIcon ] ]
			on: Error do: [ :error |
			self iconFor: anObject error: error ]
]

{ #category : #'private building' }
GTRawObjectVariablesBrowser >> iconFor: anEyeElement error: error [
	^ Smalltalk ui icons smallWarningIcon
]

{ #category : #'private building' }
GTRawObjectVariablesBrowser >> printStringOf: anObject [
	self subclassResponsibility
]

{ #category : #'private building' }
GTRawObjectVariablesBrowser >> stringWithoutInitialCommentFrom: aString [
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
GTRawObjectVariablesBrowser >> updateInstanceVariable: aSymbol from: anObject basedOn: aString [
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
GTRawObjectVariablesBrowser >> variableValuePairsFor: anObject [
	self subclassResponsibility 
]

{ #category : #'private building' }
GTRawObjectVariablesBrowser >> variablesIn: composite [
	^ composite table
		showOnly: 50;
		shouldValidate: false;
		allowsRecursiveSearch: false;
		"wantsSteps: true;"
		children: [ :assoc | 
			assoc key = 'self'
				ifTrue: [ #() ]
				ifFalse: [ self variableValuePairsFor: assoc value ] ];
		icon: [ :assoc | self iconFor: assoc value ];
		display: [ :anObject | 
			self variableValuePairsFor: anObject ];
		column: 'Variable' 
			evaluated: [:assoc | '  ', (GTObjectPrinter new asNonTruncatedTextFrom: assoc key) ];
		column: 'Value' 
			evaluated: [:assoc | GTObjectPrinter new asTruncatedTextFrom: assoc value ]
			modified: [:newValue :assoc :presentation | 
				self updateInstanceVariable: assoc key from: presentation entity basedOn: newValue.
				presentation update ];
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
			entitled: 'Open pointers to';
		dynamicActionsOnSelection: [ :presentation |
			(presentation entity class hasInstVarNamed: presentation rawSelection key)
				ifTrue: [ 
					{
						GLMGenericAction new 
								action: [:list | self systemNavigation browseAllAccessesTo: list rawSelection key from: list entity class ]; 
								title: 'List methods using this variable'.
						GLMGenericAction new 
								action: [:list | self systemNavigation browseAllStoresInto: list rawSelection key from: list entity class ]; 
								title: 'List methods storing into this variable'.		
					}
					]
				ifFalse: [ #() ] ]
]
