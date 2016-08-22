Class {
	#name : #GTExampleGraphPainter,
	#superclass : #Object,
	#instVars : [
		'example',
		'view',
		'group',
		'edges',
		'nodes',
		'fromTo',
		'processing'
	],
	#category : #'GT-Examples-UI'
}

{ #category : #private }
GTExampleGraphPainter >> buildAfter: anExample1 [
	| shape element parentNode edge line |
	
	" abort if we've done this already "
	anExample1 after ifNil: [ ^ self ].
	(nodes includesKey: anExample1 after) ifTrue: [ ^ self ].
	
	" add element and shape "
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
	
	" add edge "
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
			" retrieve existing element and shape"
			element := (nodes at: anExample1) first.
			shape := (nodes at: anExample1) second. ]
		ifFalse: [ 
			" add element and shape "
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
	
	" add edge if not already present "
	self edgeFrom: anExample2 to: anExample1 ifAbsent: [ 
		parentNode := nodes at: anExample2.
		edge := RTEdge from: parentNode first to: element.
		line := RTArrowedLine new 
			color: Color yellow; 
			attachPoint: RTVerticalAttachPoint instance;
			yourself.
		edge + line.
		edges add: edge ]
]

{ #category : #private }
GTExampleGraphPainter >> buildDependencies: anExampleOrMethod1 at: index parent: anExampleOrMethod2 [
	self process: anExampleOrMethod1 
		do: [ 
			anExampleOrMethod1 isGTExample 
				ifTrue: [ 
					" example with all dependencies "
					self buildDependency: anExampleOrMethod1 at: index parent: anExampleOrMethod2.
					anExampleOrMethod1 dependenciesOrArguments withIndexDo: [ :dep :depIndex | 
						self buildDependencies: dep at: depIndex parent: anExampleOrMethod1 ].
					self buildAfter: anExampleOrMethod1 ]
				ifFalse: [ 
					" just an argument (placeholder) - example missing "
					self buildArgument: anExampleOrMethod1 at: index parent: anExampleOrMethod2 ] ] 
		onRecursionDo: [ 
			self updateDependency: anExampleOrMethod1 at: index parent: anExampleOrMethod2 ]

]

{ #category : #private }
GTExampleGraphPainter >> buildDependency: anExample1 at: index parent: anExample2 [
	| shape element parentNode edge line |
	(nodes includesKey: anExample1) 
		ifTrue: [ 
			" retrieve existing element and shape"
			element := (nodes at: anExample1) first.
			shape := (nodes at: anExample1) second. ]
		ifFalse: [ 
			" add element and shape "
			shape := RTBox new 
				width: 16;
				height: 16;
				color: (self example == anExample1 ifTrue: [ Color lightGray ] ifFalse: [ Color white ]);
				borderColor: (anExample1 hasInternalProblems
					ifTrue: [ Color yellow ]
					ifFalse: [ Color black ]);
				borderWidth: 4;
				yourself.
			element := shape elementOn: anExample1.
			group add: element.
			nodes at: anExample1 put: { element. shape }.
			" add missing arguments "
			self buildMissingArguments: anExample1 ].
	
	" add edge if not already present "
	self edgeFrom: anExample2 to: anExample1 ifAbsent: [ 
		parentNode := nodes at: anExample2.
		edge := RTEdge from: parentNode first to: element.
		line := RTArrowedLine new 
			color: (index > anExample2 method numArgs 
				ifTrue: [ Color yellow ] 
				ifFalse: [ Color lightGray ]); 
			attachPoint: RTVerticalAttachPoint instance;
			yourself.
		edge + line.
		edges add: edge ]
]

{ #category : #private }
GTExampleGraphPainter >> buildDependent: anExample1 child: anExample2 [
	| shape element childNode edge line |
	(nodes includesKey: anExample1) 
		ifTrue: [ 
			" retrieve existing element and shape"
			element := (nodes at: anExample1) first.
			shape := (nodes at: anExample1) second. ]
		ifFalse: [
			" add element and shape "
			shape := RTBox new 
				width: 16;
				height: 16;
				color: (self example == anExample1 ifTrue: [ Color lightGray ] ifFalse: [ Color white ]);
				borderColor: (anExample1 hasInternalProblems
					ifTrue: [ Color yellow ]
					ifFalse: [ Color black ]);
				borderWidth: 4;
				yourself.
			element := shape elementOn: anExample1.
			group add: element.
			nodes at: anExample1 put: { element. shape } ].
	
	" add edge if not already present "
	self edgeFrom: anExample1 to: anExample2 ifAbsent: [ 
		childNode := nodes at: anExample2.
		edge := RTEdge from: element to: childNode first.
		line := RTArrowedLine new 
			color: Color lightGray; 
			attachPoint: RTVerticalAttachPoint instance;
			yourself.
		edge + line.
		edges add: edge ]
]

{ #category : #private }
GTExampleGraphPainter >> buildDependents: anExampleOrMethod1 child: anExampleOrMethod2 [
	self process: anExampleOrMethod1 
		do: [ 
			anExampleOrMethod1 directDependents do: [ :dep |
				self buildDependent: dep child: anExampleOrMethod1.
				self buildDependents: dep child: anExampleOrMethod1 ] ] 
		onRecursionDo: [ 
			self updateDependent: anExampleOrMethod1 child: anExampleOrMethod2 ]
]

{ #category : #private }
GTExampleGraphPainter >> buildMissingArguments: anExample1 [
	| method |
	
	" abort if we've done this already "
	method := anExample1 method.
	method numArgs > anExample1 arguments size ifFalse: [ ^ self ].
	
	(1 max: anExample1 arguments size) to: method numArgs  do: [ :index |
		| shape argumentName element edge line |
		" add shape "
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
		
		" add edge "
		edge := RTEdge from: (nodes at: anExample1) first to: element.
		line := RTArrowedLine new 
			color: Color yellow; 
			attachPoint: RTVerticalAttachPoint instance;
			yourself.
		edge + line.
		edges add: edge ]
]

{ #category : #'private-utils' }
GTExampleGraphPainter >> edgeFrom: fromExample to: toExample ifAbsent: aBlock [
	| processedEdges |
	fromExample ifNil: [ ^ self ].
	toExample ifNil: [ ^ self ].
	processedEdges := fromTo at: fromExample ifAbsentPut: [ Set new ].
	(processedEdges includes: toExample) ifTrue: [ ^ self ].
	[ aBlock value ] ensure: [ 
		processedEdges add: toExample ]
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
	processing := Set new.
	self buildDependencies: self example at: nil parent: nil.
	self buildDependents: self example child: nil.
	view addAll: group @ (RTPopup text: [ :node | node gtDisplayString ]) @ RTDraggable.
	view addAll: edges.
	RTTreeLayout new on: group.
	^ view
]

{ #category : #'private-utils' }
GTExampleGraphPainter >> process: aGTExample do: aBlock onRecursionDo: aBlock2 [
	(processing includes: aGTExample) ifTrue: [ ^ aBlock2 value ].
	processing add: aGTExample.
	[ aBlock value ] ensure: [ 
		processing remove: aGTExample ]
]

{ #category : #private }
GTExampleGraphPainter >> updateDependency: anExampleOrMethod1 at: index parent: anExampleOrMethod2 [
	| node parentNode edge line |
	
	" abort if we've done this already "
	self edgeFrom: anExampleOrMethod2 to: anExampleOrMethod1 ifAbsent: [ 
		" retrieve existing elements "
		node := nodes at: anExampleOrMethod1.
		parentNode := nodes at: anExampleOrMethod2.
		
		" add edge "
		edge := RTEdge from: parentNode first to: node first.
		line := RTArrowedLine new 
			color: Color red; 
			attachPoint: RTVerticalAttachPoint instance;
			yourself.
		edge + line.
		edges add: edge ]
]

{ #category : #private }
GTExampleGraphPainter >> updateDependent: anExampleOrMethod1 child: anExampleOrMethod2 [
	| node parentNode edge line |
	
	" abort if we've done this already "
	self edgeFrom: anExampleOrMethod1 to: anExampleOrMethod2 ifAbsent: [ 
		" retrieve existing elements "
		node := nodes at: anExampleOrMethod2.
		parentNode := nodes at: anExampleOrMethod1.
		
		" add edge "
		edge := RTEdge from: parentNode first to: node first.
		line := RTArrowedLine new 
			color: Color red; 
			attachPoint: RTVerticalAttachPoint instance;
			yourself.
		edge + line.
		edges add: edge ]
]

{ #category : #accessing }
GTExampleGraphPainter >> view [
	^ view
]

{ #category : #accessing }
GTExampleGraphPainter >> view: anObject [
	view := anObject
]
