"
I am a special browser that is used in the first pane of the inspector that is embedded in the debugger. Its main intention is to provide a unified list of variables that come from:
- the instance variables of the receiver
- the local variables from the context
"
Class {
	#name : #GTDebuggerVariablesBrowser,
	#superclass : #GLMCompositePresentation,
	#instVars : [
		'debugger'
	],
	#category : #'GT-Debugger-UI'
}

{ #category : #testing }
GTDebuggerVariablesBrowser >> compareVariableTypeOf: x withVariable: y in: aContext [

	^ (self variableTypeOf: x in: aContext) < (self variableTypeOf: y in: aContext)
]

{ #category : #building }
GTDebuggerVariablesBrowser >> compose [  
	| tabulator |
	tabulator := self tabulator.
	tabulator row: #main.
	tabulator transmit to: #main; andShow: [ :aComposite | 
		aComposite tabulator with: [:browser | 
			browser title: 'Variables'.
			browser row: #variables.
			browser transmit 
				from: #variables port: #entity; 
				to: #variables port: #selection; 
				when: [ :aContext | self debugger selectedVariableName notNil and: [aContext notNil] ];
				transformed: [ :aContext | self selectedVariableForContext: aContext ].
			browser transmit to: #variables; andShow: [:a | 
				self variablesIn: a ].
			browser transmit from: #variables; toOutsidePort: #selection; transformed: [ :pair | pair value ] ].
		aComposite tabulator with: [:browser | 
			browser title: 'Evaluator'.
			browser row: #evaluator.
			browser transmit to: #evaluator; andShow: [:a | 
				self contextEvaluatorIn: a. ].
			browser transmit from: #evaluator; toOutsidePort: #selection ].
		
		aComposite onChangeOfPort: #activePresentation act: [ :presentation |
			(presentation pane port: #activePresentation) value 
				ifNotNil: [ :activePresentation | 
					self debugger cache at: #activePresentationTitle put: activePresentation title ] ] ].
	tabulator transmit from: #main; toOutsidePort: #selection.
]

{ #category : #'private building' }
GTDebuggerVariablesBrowser >> contextEvaluatorIn: aComposite [

	aComposite pharoScript
		doItReceiver: [ self debugger selectedContext receiver ];
		doItContext: [ self debugger selectedContext ];
		smalltalkClass: [ self debugger selectedContext receiver class ];
		display: [ 
			String streamContents: [ :stream | 
				stream 
					nextPutAll: (GTSnippets snippetAt: self debugger selectedContext receiver class)] ];
		onChangeOfPort: #text act: [ :textPresentation |
				GTSnippets 
					snippetAt: self debugger selectedContext receiver class 
					put: (textPresentation text asString).
				 textPresentation clearUserEdits ];
		installDefaultSelectionActions
]

{ #category : #accessing }
GTDebuggerVariablesBrowser >> debugger [
	^ debugger
]

{ #category : #accessing }
GTDebuggerVariablesBrowser >> debugger: anObject [
	debugger := anObject
]

{ #category : #actions }
GTDebuggerVariablesBrowser >> restoreSettings [
	| currentPane presentationTitle lastActivePresentation |
	
	presentationTitle := self debugger cache at: #activePresentationTitle ifAbsent: [ nil ].
	currentPane := self presentations first paneNamed: #main.
	lastActivePresentation := currentPane presentations  presentations
		detect: [ :each | each title = presentationTitle ] 
		ifNone: [ ^ self ].
	currentPane lastActivePresentation: lastActivePresentation
]

{ #category : #building }
GTDebuggerVariablesBrowser >> selectedVariableForContext: aContext [ 
	|variablesMappings|
	
	variablesMappings := self variablesFromContext: aContext.
	^ variablesMappings 
		detect: [ :each | each key = self debugger selectedVariableName ] 
		ifNone: [ variablesMappings detect: [ :each | each key = 'self' ] ifNone: [ nil ] ]
]

{ #category : #'private building' }
GTDebuggerVariablesBrowser >> tagsForVariable: aString from: aContext [
	^ (aContext reservedNames includes: aString) 
		ifTrue: [ 'implicit' ]
		ifFalse: [ self variableTypeOf: aString in: aContext ]
			
	
]

{ #category : #building }
GTDebuggerVariablesBrowser >> variableTypeOf: aString in: aContext [
	^ (aContext receiver class classThatDefinesInstanceVariable: aString) notNil
			ifTrue: [ 'attribute' ]
			ifFalse: [ (aContext method argumentNames includes: aString)
				ifTrue: [ 'parameter' ]
				ifFalse: [ 'temp' ] ]
			
	
]

{ #category : #'private building' }
GTDebuggerVariablesBrowser >> variablesFromContext: aContext [ 

	^ aContext gtDebuggerRetrieveVariableValuePairs
]

{ #category : #'private building' }
GTDebuggerVariablesBrowser >> variablesIn: composite [
	^ composite fastTable
		showOnly: 50;
		shouldValidate: false;
		allowsRecursiveSearch: false;
		display: [ :context | self variablesFromContext: context ];
		column: 'Type'
			evaluated: [ '' ]
			width: 75
			tags: [ :assoc :context |
				self tagsForVariable: assoc key from: context ]
			sortedBy: [ :x :y | 
				self 
					compareVariableTypeOf: x key
					withVariable: y key
					in: ((self presentations first paneNamed: #variables) port: #entity) value];
		column: 'Variable' 
			evaluated: [:assoc | GTObjectPrinter asNonTruncatedTextFrom: assoc key ]
			width: 175;
		column: 'Value' evaluated: [:assoc | GTObjectPrinter asTruncatedTextFrom: assoc value ];
		"send: #value;"
		morphicSelectionAct: [:list | list selection value browse ] 
			icon: GLMUIThemeExtraIcons glamorousBrowse 
			on: $b 
			entitled: 'Browse';
		morphicSelectionAct: [:list | list selection value inspect ] 
			icon: GLMUIThemeExtraIcons glamorousInspect 
			on: $i 
			entitled: 'Inspect';
		onChangeOfPort: #rawSelection 
			act: [ :aPresentation | 
				self debugger selectedVariableName: aPresentation rawSelection key ] 
]
