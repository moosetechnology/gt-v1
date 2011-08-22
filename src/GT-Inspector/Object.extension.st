Extension { #name : #Object }

{ #category : #'*gt-inspector' }
Object >> gtInspectorEvaluatorIn: composite [
	<gtInspectorPresentationOrder: 100>
	(composite text)
		forSmalltalk;
		display: [ :entity | 'self' ];
		title: 'Evaluator';
		selectionPopulate: #selection
			on: $o
			entitled: 'Open (o)'
			with: [ :text :entity | Compiler evaluate: text selectedText for: entity logged: false ];
		selectionAct: [ :text :entity | (Compiler evaluate: text selectedText for: entity logged: false) inspect ]
			on: $/
			entitled: 'Inspect (/)'
]

{ #category : #'*gt-inspector' }
Object >> gtInspectorMethodsIn: composite [
	<gtInspectorPresentationOrder: 50>
	composite custom: (GTSimpleMethodsBrowser new browser startOn: self) 
]

{ #category : #'*gt-inspector' }
Object >> gtInspectorPresentationsIn: composite [
	| pragmas |
	pragmas := Pragma 
				allNamed: #gtInspectorPresentationOrder: 
				from: self class 
				to: Object 
				sortedUsing: [: x :y | (x argumentAt: 1) < (y argumentAt: 1)].
	pragmas do: [ :eachPragma | 
		self perform: eachPragma selector with: composite ]

]

{ #category : #'*gt-inspector' }
Object >> gtInspectorRetrieveVariableValuePairs [
	"This is a helper method that returns a collection of variable names -> value for the current object.
	Subclasses can override it to specialize what appears in the variables presentation"
	^ (OrderedCollection new)
		add: 'self' -> self;
		addAll: (self class allInstVarNames collect: [ :iv | iv -> (self instVarNamed: iv) ]);
		yourself
]

{ #category : #'*gt-inspector' }
Object >> gtInspectorVariablesIn: composite [
	<gtInspectorPresentationOrder: 10>
	composite table
		title: 'Variables';
		showOnly: 50;
		display: [ :anObject | self gtInspectorRetrieveVariableValuePairs ];
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
