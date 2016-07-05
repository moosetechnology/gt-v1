Class {
	#name : #GTExampleView,
	#superclass : #Object,
	#instVars : [
		'example'
	],
	#category : #'GT-Examples-TODO'
}

{ #category : #private }
GTExampleView >> buildEdges: aBlock for: aGroup on: aView [
	| edges container fromElement toElements elementsWithModels |
	aGroup isEmpty ifTrue: [ ^ #() ].
	edges := OrderedCollection new.
	elementsWithModels := aGroup select: [ :el | el model notNil ].
	
	elementsWithModels do: [ :element |
		container := element view.
		fromElement := container elementFromModel: (#yourself rtValue: element model).
		
		"We get the list of elements that corresponds to (toBlock roValues: element model)"
		toElements := OrderedCollection new.
		([ :node | node dependenciesOrArguments ] rtValue: element model) do: [ :model | 
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
GTExampleView >> createShape: aGTExample for: aGroup on: aView [
	| shape | 
	shape := RTBox new 
		size: 32;
		color: Color black;
		borderColor: (aGTExample isValid ifTrue: [ Color black ] ifFalse: [ Color yellow ]);
		borderWidth: 2;
		yourself.
	aGroup add: (shape elementOn: aGTExample).
	^ shape
]

{ #category : #accessing }
GTExampleView >> example [
	^ example
]

{ #category : #accessing }
GTExampleView >> example: anObject [
	example := anObject
]

{ #category : #ui }
GTExampleView >> gtInspectorRoassalIn: composite [
	self hasRoassal2 ifFalse: [ ^ self ].
	^ composite roassal2
		title: 'Graph';
		painting: [ :view :node | self viewGraph: node on: view ];
		yourself
]

{ #category : #testing }
GTExampleView >> hasRoassal2 [
	^ (Smalltalk classNamed: #GLMRoassal2Presentation) notNil
]

{ #category : #private }
GTExampleView >> shape: aGTExample do: aBlock for: aGroup on: aView [
	aBlock value: ((self shapeOf: aGTExample for: aGroup on: aView) 
		ifNil: [ self createShape: aGTExample for: aGroup on: aView ])
]

{ #category : #accessing }
GTExampleView >> shapeOf: aGTExample for: aGroup on: aView [
	^ aGroup 
		detect: [ :shape | shape model == aGTExample ] 
		ifNone: [ nil ]
]

{ #category : #private }
GTExampleView >> viewGraph: aRootExample on: aView [
	| shapes traverser |
	
	Smalltalk gtExamplesContained. " force all examples to be built "
	
	shapes := RTGroup new.
	
	" root node "
	self shape: aRootExample do: [ :shape | shape size: 64 ] for: shapes on: aView.
	
	" dependencies "
	(traverser := aRootExample traverser)
		onRecursionError: [ :aProcessor :anExample | 
			self shape: anExample do: [ :shape | shape color: Color red ] for: shapes on: aView ];
		action: [ :anExample | 
			self shape: anExample do: [ :shape | ] for: shapes on: aView ];
		value.
		
	" dependents "
	traverser reversed value.
	
	" add to view "
	aView addAll: shapes @ (RTPopup text: [ :node | node gtDisplayString ]) @ RTDraggable.
	
	(RTTreeLayout new
		verticalGap: 10;
		horizontalGap: 10;
		yourself) on: shapes.
	
	" edges "
	self buildEdges: [ :edge :from :to :line | 
		from model hasValidArguments 
			ifFalse: [ 
				from borderColor: Color yellow.
				line color: Color yellow ] ] for: shapes on: aView.
		
	^ aView resetCamera
]
