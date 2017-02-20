"
This is a helper browser for the Raw view in the GTInspector. It provides an overview of the slots and it offers an evaluator.
"
Class {
	#name : #GTRawObjectVariablesBrowser,
	#superclass : #GLMCompositePresentation,
	#instVars : [
		'cachedHashes'
	],
	#category : #'GT-Inspector'
}

{ #category : #'private building' }
GTRawObjectVariablesBrowser >> basicVariableNodesFor: anObject [

	^ #()
]

{ #category : #'private building' }
GTRawObjectVariablesBrowser >> basicVariableNodesFor: anObject in: aCollection [

	self subclassResponsibility 
]

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
			transformed: [ :aNode | aNode ifNotNil: [aNode value]].
		browser transmit 
			from: #evaluator; 
			toOutsidePort: #selection ]
]

{ #category : #'private building' }
GTRawObjectVariablesBrowser >> evaluatorIn: composite [
	^ composite pharoScript
		doItReceiver: [ :object | object ];
		smalltalkClass: [ :object | object class ];
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

{ #category : #'private - updating' }
GTRawObjectVariablesBrowser >> generateCacheFor: anObject [
	| valuesCache |
	
	valuesCache := OrderedDictionary new.
	((self basicVariableNodesFor: anObject) do: [ :assoc | 
		valuesCache 
			at: assoc key 
			put: (self generateHashFor: assoc value) ]).
	
	^ valuesCache
]

{ #category : #'private - updating' }
GTRawObjectVariablesBrowser >> generateHashFor: anObject [ 

	^ (self basicVariableNodesFor: anObject)
		inject: anObject gtInspectorHash
		into: [ :hashValue :assoc | hashValue bitXor: assoc value gtInspectorHash ].
	
	
]

{ #category : #'private building' }
GTRawObjectVariablesBrowser >> iconFor: anObject [
		
	^ [ (anObject iconOrThumbnailOfSize: 16)
		ifNil: [ anObject class systemIcon ] ]
			on: Error do: [ :error | self iconFor: anObject error: error ]
]

{ #category : #'private building' }
GTRawObjectVariablesBrowser >> iconFor: anEyeElement error: error [
	^ self iconNamed: #smallWarningIcon
]

{ #category : #'private building' }
GTRawObjectVariablesBrowser >> printStringOf: anObject [
	self subclassResponsibility
]

{ #category : #'private - updating' }
GTRawObjectVariablesBrowser >> rebuildCacheFor: anObject [

	cachedHashes := self generateCacheFor: anObject
]

{ #category : #'private - updating' }
GTRawObjectVariablesBrowser >> shouldRefresh [
	|newCache result|

	newCache := self generateCacheFor: self entity.
	result := cachedHashes ~= newCache.
	cachedHashes := newCache.
	^ result
]

{ #category : #'private building' }
GTRawObjectVariablesBrowser >> stringWithoutInitialCommentFrom: aString [
	^ (aString trimLeft isEmpty not and: [ aString trimLeft first = $" ])
		ifFalse: [ aString trimRight ]
		ifTrue: [|startIndex doubleQuoteCounter|
			startIndex := aString findAnySubstring: '"' startingAt: (aString indexOf: $") + 1.
			doubleQuoteCounter := 1.
			"we need to iterate over the whole string queuing quotes to support nested double quotes"
			[ startIndex <= aString size
				and: [ doubleQuoteCounter % 2 = 1
					or: [ (aString at: startIndex) = $"
						or: [ (aString at: startIndex) isSeparator ] ] ] ]
			whileTrue: [ 
				(aString at: startIndex) = $" ifTrue: [ 
					doubleQuoteCounter := doubleQuoteCounter + 1 ].
				startIndex := startIndex + 1 ].
	
			(startIndex >= (aString size + 1)) ifTrue: [ "No content if a comment cannot be identified. " ^ '' ].
			(aString
				copyFrom: startIndex
				to: aString size) trimBoth ]
]

{ #category : #'private building' }
GTRawObjectVariablesBrowser >> updateInstanceVariable: aSymbol from: anObject basedOn: aString [
	| aResult |

	self
		assert: [ anObject class hasInstVarNamed: aSymbol ]
		description: [ 'Instance variable ', aSymbol asString, ' must exist in ', anObject asString ].

	aResult := anObject class compiler
			source: aString;
			context: nil;
			receiver: anObject;
			failBlock: [ ^ self ];
			evaluate.
						
	anObject writeSlotNamed: aSymbol value: aResult
]

{ #category : #'private building' }
GTRawObjectVariablesBrowser >> variableNodesFor: anObject [
	| variableNodes |

	"Nil should have now a single child: `self`. For now this is needed for
	a smooth navigation in the tree widget."
	"anObject ifNil: [ ^ #() ]."

	variableNodes := OrderedCollection new: anObject class allSlots size.
	variableNodes add: (GTInspectorSelfNode hostObject: anObject).
	self basicVariableNodesFor: anObject in: variableNodes.
	^ variableNodes
]

{ #category : #'private building' }
GTRawObjectVariablesBrowser >> variablesIn: composite [
	^ composite fastTreeTable
		hasChildren: [ :aNode | aNode key ~= 'self' ];
		children: [ :aNode | aNode childrenNodesFor: self ];
		icon: [ :aNode | self iconFor: aNode value ];
		display: [ :anObject | 
			"self rebuildCacheFor: anObject."
			self variableNodesFor: anObject ];
		column: 'Variable' translated
			evaluated: [ :aNode | (GTObjectPrinter asNonTruncatedTextFrom: aNode key) ];
		column: 'Value' translated
			evaluated: [ :aNode | GTObjectPrinter asTruncatedTextFrom: aNode value ];
		morphicSelectionAct: [:list | list selection value browse ] 
			icon: GLMUIThemeExtraIcons glamorousBrowse 
			on: $b 
			entitled: 'Browse' translated;
		morphicSelectionAct: [:list | list selection value inspect ] 
			icon: GLMUIThemeExtraIcons glamorousInspect 
			on: $i 
			entitled: 'Inspect' translated;
		dynamicActionsOnSelection: [ :presentation |
			presentation selection inspectorActionsForNode ];
		selectionAct: [:list | 
			((list selection value pointersToExcept: { list selection value })
									reject: [ :each | each pointsOnlyWeaklyTo: list selection value ]) inspect ] 
			on: $t
			entitled: 'Open pointers to' translated
	
]
