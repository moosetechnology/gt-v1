Class {
	#name : #GTExamplePainter,
	#superclass : #Object,
	#instVars : [
		'example',
		'elements'
	],
	#category : #'GT-Inspector-Examples-UI'
}

{ #category : #private }
GTExamplePainter >> borderColorForExample: anExample [
	^ [ self colorForResult: anExample result ]
		on: Error
		do: [ self colorForExample: anExample ]
]

{ #category : #private }
GTExamplePainter >> buildEdges: aBlock inView: aView [
	| edges container fromElement toElements elementsWithModels |
	elements isEmpty ifTrue: [ ^ #() ].
	edges := OrderedCollection new.
	elementsWithModels := elements select: [ :el | el model notNil ].
	
	elementsWithModels do: [ :element |
		container := element view.
		fromElement := container elementFromModel: (#yourself rtValue: element model).
		
		"We get the list of elements that corresponds to (toBlock roValues: element model)"
		toElements := OrderedCollection new.
		([ :node | self dependenciesOrArgumentsForExample: node ] rtValue: element model) do: [ :model | 
			| v |
			v := container elementFromModel: model.
			v notNil ifTrue: [ toElements add: v ] ].
		
		
		(fromElement notNil and: [ toElements notEmpty ])
			ifTrue: [  
				toElements do: [ :toElement |
					| edge line |
					edge := RTEdge from: fromElement to: toElement. 
					line := RTArrowedLine new 
						color: Color black; 
						attachPoint: RTVerticalAttachPoint instance;
						yourself.
					aBlock value: edge value: fromElement value: toElement value: line.
					edge + line.
					edges add: edge.
					container add: edge ] ]  ].
	aView addAll: edges.
]

{ #category : #private }
GTExamplePainter >> buildElements: aRootExample inView: aView [
	| traverser |
	" init "
	elements := RTGroup new.
	
	" root element "
	elements add: (self elementForExample: aRootExample with: [ :shape | shape size: 48 ]).
	
	" top-down "
	(traverser := aRootExample traverser)
		onRecursionError: [ :aProcessor :anExample | self onRecursionError: anExample ];
		onArgumentError: [ :aProcessor :anExample :someArguments | self onArgumentError: anExample ];
		onDependencyError: [ :aProcessor :anExample :anException | self onDependencyError: anExample ];
		action: [ :anExample | self onAction: anExample ];
		value.
	
	" bottom up "
	traverser reversed value.
	
	" add to view "
	aView addAll: elements @ (RTPopup text: [ :node | node gtDisplayString ]) @ RTDraggable.
]

{ #category : #private }
GTExamplePainter >> buildLayoutinView: aView [
	" layout -> graph instead of tree "
	RTTreeLayout new on: elements
]

{ #category : #private }
GTExamplePainter >> colorForExample: anExample [
	^ anExample exists 
		ifTrue: [ anExample isValid 
			ifTrue: [ self defaultColorForExample: anExample ] 
			ifFalse: [ Color red ] ] 
		ifFalse: [ (Color r: 1 g: 0 b: 0 alpha: 0.05) ]
]

{ #category : #private }
GTExamplePainter >> colorForResult: aResult [
	aResult isSuccess ifTrue: [ ^ Color green ].
	aResult isFailure ifTrue: [ ^ Color yellow ].
	aResult isError ifTrue: [ ^ Color red ].
	^ self defaultColorForExample: nil
]

{ #category : #private }
GTExamplePainter >> defaultColorForExample: anExample [
	^ Color black
]

{ #category : #private }
GTExamplePainter >> dependenciesOrArgumentsForExample: anExample [
	^ [ anExample arguments collect: [ :each | 
		[ each example ] 
			on: Error 
			do: [ :exception | each ] ] ] on: Error do: [ #() ]
]

{ #category : #private }
GTExamplePainter >> elementByExample: anExample [
	^ elements 
		detect: [ :element | element model == anExample ] 
		ifNone: [ nil ]
]

{ #category : #private }
GTExamplePainter >> elementByExample: anExample do: aBlock1 ifNone: aBlock2 [
	(self elementByExample: anExample)
		ifNotNil: aBlock1
		ifNil: aBlock2
]

{ #category : #private }
GTExamplePainter >> elementForExample: anExample [
	^ self elementForExample: anExample with: [ :shape | ]
]

{ #category : #private }
GTExamplePainter >> elementForExample: anExample with: aBlock [
	| shape |
	shape := RTBox new 
		size: 24;
		color: (self defaultColorForExample: anExample);
		borderColor: (self borderColorForExample: anExample);
		borderWidth: 2;
		yourself.
	aBlock value: shape.
	^ shape elementOn: anExample
]

{ #category : #accessing }
GTExamplePainter >> example [
	^ example
]

{ #category : #accessing }
GTExamplePainter >> example: anObject [
	example := anObject
]

{ #category : #public }
GTExamplePainter >> gtInspectorRoassalIn: composite [
	self hasRoassal2 ifFalse: [ ^ self ].
	^ composite roassal2
		title: 'Graph';
		painting: [ :view :node | self viewGraph: node on: view ];
		yourself
]

{ #category : #private }
GTExamplePainter >> hasRoassal2 [
	^ (Smalltalk classNamed: #GLMRoassal2Presentation) notNil
]

{ #category : #private }
GTExamplePainter >> onAction: anExample [
	self elementByExample: anExample
		do: [ :element | ]
		ifNone: [ elements add: (self elementForExample: anExample) ] 
]

{ #category : #private }
GTExamplePainter >> onArgumentError: anExample [
	self elementByExample: anExample
		do: [ :element | 
			element color: Color red.
			(self dependenciesOrArgumentsForExample: anExample) do: [ :argument |
				self elementByExample: argument
					do: [ :subElement | ]
					ifNone: [ elements add: (self elementForExample: argument with: [ :shape | shape 
							color: (self colorForExample: argument); 
							borderColor: (self borderColorForExample: argument) ]) ] ] ]
		ifNone: [ ] 
]

{ #category : #private }
GTExamplePainter >> onDependencyError: anExample [
	self elementByExample: anExample
		do: [ :element | 
			anExample hasValidArguments 
				ifFalse: [ element color: Color red ] ]
		ifNone: [ 
			elements add: (self elementForExample: anExample) ].
		
	anExample arguments do: [ :argument |
		elements add: (self elementForExample: argument with: [ :shape | shape 
			color: (self colorForExample: argument); 
			borderColor: (self borderColorForExample: argument) ]) ] 
]

{ #category : #private }
GTExamplePainter >> onRecursionError: anExample [
	self elementByExample: anExample
		do: [ :element | element color: Color yellow ]
		ifNone: [  ] 
]

{ #category : #'private-painting' }
GTExamplePainter >> viewGraph: aRootExample on: aView [
	self buildElements: aRootExample inView: aView.
	self buildEdges: [ :edge :from :to :line | 
		from model hasValidArguments ifFalse: [ line color: Color red ] ] inView: aView.
	self buildLayoutinView: aView.
	
	^ aView
]
