Class {
	#name : #GTExampleGraphPainter,
	#superclass : #Object,
	#instVars : [
		'example',
		'view',
		'group',
		'nodes',
		'edges',
		'fromTo',
		'processing'
	],
	#category : #'GT-Examples-UI'
}

{ #category : #private }
GTExampleGraphPainter >> buildAfter: anExample1 [
	| shape element parentNode edge line |
	anExample1 after ifNil: [ ^ self ].
	(nodes includesKey: anExample1 after) ifTrue: [ ^ self ].
	shape := RTEllipse new 
		width: 8;
		height: 8;
		color: Color white;
		borderColor: (anExample1 after isValid 
			ifTrue: [ Color black ]
			ifFalse: [ Color yellow alpha: 0.05 ]);
		borderWidth: 1;
		yourself.
	element := shape elementOn: anExample1.
	group add: element.
	nodes at: anExample1 after put: { element. shape }.
	
	parentNode := nodes at: anExample1.
	edge := RTEdge from: parentNode first to: element.
	line := RTLine new 
		color: (anExample1 after isValid 
			ifTrue: [ Color black ]
			ifFalse: [ Color yellow ]); 
		attachPoint: RTVerticalAttachPoint instance;
		yourself.
	edge + line.
	edges add: edge
]

{ #category : #private }
GTExampleGraphPainter >> buildArgument: anExample1 at: index parent: anExample2 [
	| shape element parentNode edge line |
	(nodes includesKey: anExample1) 
		ifTrue: [ 
			element := (nodes at: anExample1) first.
			shape := (nodes at: anExample1) second. ]
		ifFalse: [ 
			shape := RTBox new 
				width: 8;
				height: 8;
				color: Color white;
				borderColor: (Color black alpha: 0.05);
				borderWidth: 4;
				yourself.
			element := shape elementOn: anExample1.
			group add: element.
			nodes at: anExample1 put: { element. shape } ].
	
	anExample2 ifNotNil: [
		fromTo at: anExample2 ifAbsent: [ 
			parentNode := nodes at: anExample2.
			edge := RTEdge from: parentNode first to: element.
			line := RTArrowedLine new 
				color: Color yellow; 
				attachPoint: RTVerticalAttachPoint instance;
				yourself.
			edge + line.
			edges add: edge.
			fromTo at: anExample2 put: anExample1 ] ]
]

{ #category : #private }
GTExampleGraphPainter >> buildDependencies: anExampleOrMethod1 at: index parent: anExampleOrMethod2 [
	(processing includes: anExampleOrMethod1) ifTrue: [ 
		^ self updateDependency: anExampleOrMethod1 at: index parent: anExampleOrMethod2 ].
	processing add: anExampleOrMethod1.
	anExampleOrMethod1 isGTExample 
		ifTrue: [ 
			self buildDependency: anExampleOrMethod1 at: index parent: anExampleOrMethod2.
			anExampleOrMethod1 dependenciesOrArguments withIndexDo: [ :dep :depIndex | 
				self buildDependencies: dep at: depIndex parent: anExampleOrMethod1 ].
			self buildAfter: anExampleOrMethod1 ]
		ifFalse: [ 
			self buildArgument: anExampleOrMethod1 at: index parent: anExampleOrMethod2 ].
	processing remove: anExampleOrMethod1.
]

{ #category : #private }
GTExampleGraphPainter >> buildDependency: anExample1 at: index parent: anExample2 [
	| shape element parentNode edge line |
	(nodes includesKey: anExample1) 
		ifTrue: [ 
			element := (nodes at: anExample1) first.
			shape := (nodes at: anExample1) second. ]
		ifFalse: [ 
			shape := RTBox new 
				width: (self example == anExample1 ifTrue: [ 32 ] ifFalse: [ 16 ]);
				height: (self example == anExample1 ifTrue: [ 32 ] ifFalse: [ 16 ]);
				color: Color white;
				borderColor: (anExample1 hasInternalProblems
					ifTrue: [ Color yellow ]
					ifFalse: [ Color black ]);
				borderWidth: 4;
				yourself.
			element := shape elementOn: anExample1.
			group add: element.
			nodes at: anExample1 put: { element. shape }.
			self buildMissingArguments: anExample1 ].
	
	anExample2 ifNotNil: [ 
		fromTo at: anExample2 ifAbsent: [ 
			parentNode := nodes at: anExample2.
			edge := RTEdge from: parentNode first to: element.
			line := RTArrowedLine new 
				color: (index > anExample2 method numArgs 
					ifTrue: [ Color yellow ] 
					ifFalse: [ Color black ]); 
				attachPoint: RTVerticalAttachPoint instance;
				yourself.
			edge + line.
			edges add: edge.
			fromTo at: anExample2 put: anExample1 ] ]
]

{ #category : #private }
GTExampleGraphPainter >> buildDependent: anExample1 child: anExample2 [
	| shape element childNode edge line |
	(nodes includesKey: anExample1) 
		ifTrue: [ 
			element := (nodes at: anExample1) first.
			shape := (nodes at: anExample1) second. ]
		ifFalse: [
			shape := RTBox new 
				width: (self example == anExample1 ifTrue: [ 32 ] ifFalse: [ 16 ]);
				height: (self example == anExample1 ifTrue: [ 32 ] ifFalse: [ 16 ]);
				color: Color white;
				borderColor: (anExample1 hasInternalProblems
					ifTrue: [ Color yellow ]
					ifFalse: [ Color black ]);
				borderWidth: 4;
				yourself.
			element := shape elementOn: anExample1.
			group add: element.
			nodes at: anExample1 put: { element. shape } ].
	
	anExample2 ifNotNil: [ 
		fromTo at: anExample1 ifAbsent: [ 
			childNode := nodes at: anExample2.
			edge := RTEdge from: element to: childNode first.
			line := RTArrowedLine new 
				color: Color black; 
				attachPoint: RTVerticalAttachPoint instance;
				yourself.
			edge + line.
			edges add: edge.
			fromTo at: anExample1 put: anExample2 ] ]
]

{ #category : #private }
GTExampleGraphPainter >> buildDependents: anExampleOrMethod1 [
	(processing includes: anExampleOrMethod1) ifTrue: [ ^ self ].
	processing add: anExampleOrMethod1.
	anExampleOrMethod1 directDependents do: [ :dep |
		self buildDependent: dep child: anExampleOrMethod1.
		self buildDependents: dep ].
	processing remove: anExampleOrMethod1.
]

{ #category : #private }
GTExampleGraphPainter >> buildMissingArguments: anExample1 [
	| method |
	method := anExample1 method.
	method numArgs > anExample1 arguments size ifFalse: [ ^ self ].
	(1 max: anExample1 arguments size) to: method numArgs  do: [ :index |
		| shape argumentName element edge line |
		shape := RTBox new 
			width: 8;
			height: 8;
			color: Color white;
			color: Color white;
			borderWidth: 4;
			yourself.
		argumentName := method argumentNames at: index.
		element := shape elementOn: argumentName asString.
		group add: element.
		edge := RTEdge from: (nodes at: anExample1) first to: element.
		line := RTArrowedLine new 
			color: Color yellow; 
			attachPoint: RTVerticalAttachPoint instance;
			yourself.
		edge + line.
		edges add: edge ]
]

{ #category : #accessing }
GTExampleGraphPainter >> example [
	^ example
]

{ #category : #accessing }
GTExampleGraphPainter >> example: anObject [
	example := anObject
]

{ #category : #public }
GTExampleGraphPainter >> paint [
	group := RTGroup new.
	edges := OrderedCollection new.
	fromTo := Dictionary new.
	nodes := Dictionary new.
	processing := IdentitySet new.
	self buildDependencies: self example at: nil parent: nil.
	self buildDependents: self example.
	view addAll: group @ (RTPopup text: [ :node | node gtDisplayString ]) @ RTDraggable.
	view addAll: edges.
	RTTreeLayout new on: group.
	^ view
]

{ #category : #private }
GTExampleGraphPainter >> updateDependency: anExampleOrMethod1 at: index parent: anExampleOrMethod2 [
	| node parentNode edge line |
	fromTo at: anExampleOrMethod2 ifAbsent: [ 
		node := nodes at: anExampleOrMethod1.
		parentNode := nodes at: anExampleOrMethod2.
		edge := RTEdge from: parentNode first to: node first.
		line := RTArrowedLine new 
			color: Color red; 
			attachPoint: RTVerticalAttachPoint instance;
			yourself.
		edge + line.
		edges add: edge.
		fromTo at: anExampleOrMethod2 put: anExampleOrMethod1 ]
]

{ #category : #accessing }
GTExampleGraphPainter >> view [
	^ view
]

{ #category : #accessing }
GTExampleGraphPainter >> view: anObject [
	view := anObject
]
