Class {
	#name : #GTDebuggerVariablesBrowser,
	#superclass : #GLMBrowserTemplate,
	#category : #'GT-Debugger'
}

{ #category : #building }
GTDebuggerVariablesBrowser >> buildBrowser [ 
	browser := GLMTabulator new.
	browser title: [:each | each asString].
	browser row: #variables; row: #evaluator.
	browser transmit to: #variables; andShow: [:a | 
		self variablesIn: a ].
	browser transmit to: #evaluator; andShow: [:a | 
		self evaluatorIn: a ].
	browser transmit from: #variables; toOutsidePort: #selection.
	browser transmit from: #evaluator; toOutsidePort: #selection.
	^ browser 
]

{ #category : #'private building' }
GTDebuggerVariablesBrowser >> evaluatorIn: composite [
	(composite smalltalkCode)
		doItReceiver: #yourself;
		display: [ :model | [model receiver printString asSmalltalkComment, String cr, 'self'] on: Error do: ['"Error printing. Try self printString to debug"'] ];
		selectionPopulate: #selection
			on: $o
			entitled: 'Do it and open (o)'
			with: [ :text :model | Compiler evaluate: text selectedText for: model receiver logged: false ]
]

{ #category : #'private building' }
GTDebuggerVariablesBrowser >> variablesIn: composite [
	composite table
		showOnly: 50;
		display: [ :anObject | anObject gtDebuggerRetrieveVariableValuePairs ];
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
		morphicSelectionAct: [:each | each value browse ] 
			icon: GLMUIThemeExtraIcons glamorousBrowse 
			on: $b 
			entitled: 'Browse'
]
