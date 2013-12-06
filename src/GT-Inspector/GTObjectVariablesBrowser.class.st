"
This is a helper browser for the main view in the GTInspector.

Example:
self openOn: Smalltalk
"
Class {
	#name : #GTObjectVariablesBrowser,
	#superclass : #GLMBrowserTemplate,
	#category : #'GT-Inspector'
}

{ #category : #building }
GTObjectVariablesBrowser >> buildBrowser [ 
	browser := GLMTabulator new.
	browser title: 'State'.
	browser row: #variables; row: #evaluator.
	browser transmit to: #variables; andShow: [:a | 
		self variablesIn: a ].
	browser transmit to: #evaluator; andShow: [:a | 
		self evaluatorIn: a ].
	browser transmit from: #variables; toOutsidePort: #selection.
	browser transmit from: #evaluator; toOutsidePort: #selection.
	browser transmit from: #variables port: #strongSelection; toOutsidePort: #strongSelection.
	browser transmit from: #evaluator port: #strongSelection; toOutsidePort: #strongSelection.
	^ browser 
]

{ #category : #'private building' }
GTObjectVariablesBrowser >> evaluatorIn: composite [
	(composite smalltalkCode)
		doItReceiver: #yourself;
		display: [ :object | 
			String streamContents: [ :stream | 
				stream 
					nextPutAll: (self printStringOf: object);
					cr;
					nextPutAll: (GTSnippets snippetAt: object)] ];
		selectionPopulate: #selection
			on: $o
			entitled: 'Do it and open (o)'
			with: [ :text :entity | Compiler evaluate: text selectedText for: entity logged: false ] 
]

{ #category : #'private building' }
GTObjectVariablesBrowser >> printStringOf: anObject [
	^ [(anObject printString contractTo: 200) asSmalltalkComment] 
			on: Error 
			do: ['"Error printing. Try self printString to debug"']
]

{ #category : #'private building' }
GTObjectVariablesBrowser >> variablesIn: composite [
	composite table
		showOnly: 50;
		display: [ :anObject | anObject gtInspectorRetrieveVariableValuePairs ];
		sorted: [:assoc1 :assoc2 | assoc1 key < assoc2 key];
		column: 'Variable' evaluated: [:assoc | 
			[ Text fromString: assoc key asString ]
						on: Error
						do: [ Text string: 'error printing' attribute: TextColor red ] ];
		column: 'Value' evaluated: [:assoc | 
			[ Text fromString: (assoc value printString contractTo: 50) ]
						on: Error
						do: [ Text string: 'error printing' attribute: TextColor red ] ];
"		icon: [ :each |
			each value class theNonMetaClass browserIcon
				ifNotNil: [ OBMorphicIcons iconNamed: each value class theNonMetaClass browserIcon ] ];"
		send: #value;
		morphicSelectionAct: [:list | list selection value browse ] 
			icon: GLMUIThemeExtraIcons glamorousBrowse 
			on: $b 
			entitled: 'Browse';
		morphicSelectionAct: [:list | list selection value inspect ] 
			icon: GLMUIThemeExtraIcons glamorousInspect 
			on: $i 
			entitled: 'Inspect'
]
