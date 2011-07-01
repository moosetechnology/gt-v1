Extension { #name : #Object }

{ #category : #'*gt-inspector' }
Object >> finderVariablesFor: anObject [
	^ (OrderedCollection new)
		add: 'self' -> anObject;
		addAll: (anObject class allInstVarNames collect: [ :iv | iv -> (anObject instVarNamed: iv) ]);
		yourself
]

{ #category : #'*gt-inspector' }
Object >> objectFinderEvaluatorIn: composite [
	<objectFinderPresentationOrder: 100>
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
Object >> objectFinderMethodsIn: composite [
	<objectFinderPresentationOrder: 50>
	composite custom: (GTSimpleMethodsBrowser new browser startOn: self) 
]

{ #category : #'*gt-inspector' }
Object >> objectFinderPresentationsIn: composite [
	| pragmas |
	pragmas := Pragma 
				allNamed: #objectFinderPresentationOrder: 
				from: self class 
				to: Object 
				sortedUsing: [: x :y | (x argumentAt: 1) < (y argumentAt: 1)].
	pragmas do: [ :eachPragma | 
		self perform: eachPragma selector with: composite ]

]

{ #category : #'*gt-inspector' }
Object >> objectFinderVariablesIn: composite [
	<objectFinderPresentationOrder: 10>
	(composite list)
		title: 'Variables';
		display: [ :anObject | self finderVariablesFor: anObject ];
		format: [ :assoc |
			| keyString valueString | 
			keyString := [Text fromString: assoc key asString] 
							on: Error 
							do: [Text string: 'error printing' attribute: TextColor red].
			valueString := [Text fromString: (assoc value printString copyFrom: 1 to: ((50 min: assoc value printString size) max: 0))] 
							on: Error 
							do: [Text string: 'error printing' attribute: TextColor red].
			keyString , (Text fromString: ' : ') , valueString ];
		icon: [ :each | each value class theNonMetaClass browserIcon ifNotNil: [OBMorphicIcons iconNamed: each value class theNonMetaClass browserIcon] ];
		send: #value
]
