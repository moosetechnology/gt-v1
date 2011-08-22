Class {
	#name : #GTObjectVariablesBrowser,
	#superclass : #GLMBrowserTemplate,
	#category : #'GT-Inspector'
}

{ #category : #building }
GTObjectVariablesBrowser >> buildBrowser [ 
	browser := GLMTabulator new.
	browser title: 'State'.
	browser row: #variables span: 2; row: #evaluator.
	browser transmit to: #variables; andShow: [:a | 
		self variablesIn: a ].
	browser transmit to: #evaluator; andShow: [:a | 
		self evaluatorIn: a ].
	browser transmit from: #evaluator; toOutsidePort: #selection.
	^ browser 
]

{ #category : #'private building' }
GTObjectVariablesBrowser >> evaluatorIn: composite [
	(composite text)
		forSmalltalk;
		display: [ :entity | ['"', entity printString, '"', String cr, 'self'] on: Error do: ['"Error printing. Try self printString to debug"'] ];
		selectionPopulate: #selection
			on: $o
			entitled: 'Do it and open (o)'
			with: [ :text :entity | Compiler evaluate: text selectedText for: entity logged: false ];
		selectionAct: [ :text :entity | Compiler evaluate: text selectedText for: entity logged: false ]
			on: $d
			entitled: 'Do it (d)';
		selectionAct: [ :text :entity | (Compiler evaluate: text selectedText for: entity logged: false) inspect ]
			on: $i
			entitled: 'Inspect (i)';
		selectionAct: [ :text :entity | (Compiler evaluate: text selectedText for: entity logged: false) explore ]
			on: $I
			entitled: 'Explore (I)'
]

{ #category : #'private building' }
GTObjectVariablesBrowser >> variablesIn: composite [
	composite table
		showOnly: 50;
		display: [ :anObject | self gtInspectorRetrieveVariableValuePairs ];
		sorted: [:assoc1 :assoc2 | assoc1 key < assoc2 key];
		column: 'Variable' evaluated: [:assoc | 
			[ Text fromString: assoc key asString ]
						on: Error
						do: [ Text string: 'error printing' attribute: TextColor red ] ];
		column: 'Value' evaluated: [:assoc | 
			[ Text fromString: (assoc value printString contractTo: 50) ]
						on: Error
						do: [ Text string: 'error printing' attribute: TextColor red ] ];
		icon: [ :each | 
			each value class theNonMetaClass browserIcon
				ifNotNil: [ OBMorphicIcons iconNamed: each value class theNonMetaClass browserIcon ] ];
		send: #value;
		morphicSelectionAct: [:each | each value browse ] 
			icon: GLMUIThemeExtraIcons glamorousBrowse 
			on: $b 
			entitled: 'Browse'
]
