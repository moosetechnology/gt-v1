Class {
	#name : #GTSeasideDebugger,
	#superclass : #GTGenericStackDebugger,
	#category : #'GT-SeasideDebugger'
}

{ #category : #query }
GTSeasideDebugger class >> collectContextMatching: aBlock until: aTerminationBlock startingFrom: aContext [
	| currentContext counter collectedContexts|
	
	collectedContexts := OrderedCollection new.
	currentContext := aContext.
	counter := 1.
	[ currentContext notNil 
		and: [counter < 9999 
			and: [ (aTerminationBlock value: currentContext) not ] ] ] 
		whileTrue: [
			(aBlock value: currentContext) ifTrue: [ 
				collectedContexts add: currentContext ].
			currentContext := currentContext sender.
			counter := counter + 1 ].
	^ collectedContexts
]

{ #category : #accessing }
GTSeasideDebugger class >> defaultTitle [

	^ 'Seaside'
]

{ #category : #query }
GTSeasideDebugger class >> findContextMatching: aBlock startingFrom: aContext [
	| currentContext counter |
	
	currentContext := aContext.
	counter := 1.
	[ currentContext notNil and: [counter < 9999 ]] 
		whileTrue: [
			(aBlock value: currentContext) ifTrue: [ ^ currentContext ].
			currentContext := currentContext sender.
			counter := counter + 1 ].
	^ nil
]

{ #category : #testing }
GTSeasideDebugger class >> handlesContext: aContext [ 
	
	^ (self 
		findContextMatching: [ :ctxt | 
			ctxt methodClass = WASession and: [
				ctxt methodSelector = #start ] ] 
		startingFrom: aContext) notNil
]

{ #category : #'tools registry' }
GTSeasideDebugger class >> register [

	self registerToolsOn: Smalltalk tools.
]

{ #category : #'tools registry' }
GTSeasideDebugger class >> registerToolsOn: registry [

	"Add ourselves to registry. See [Smalltalk tools]" 
	registry registerDebugger: self withRank: 20.
]

{ #category : #'building presentations' }
GTSeasideDebugger >> componentsNestingIn: aComposite [
	|nestedComponents|

	nestedComponents := self class
		collectContextMatching: [ :ctxt |
			ctxt outerContext isNil and: [ 
				(ctxt methodClass =  WAComponent) and: [ 
					ctxt methodSelector = #acceptDecorated: ] ] ]
		until: [ :ctxt |
			ctxt outerContext isNil and: [ 
				ctxt methodClass = WARequestContext and: [ 
					ctxt methodSelector = #respond: ] ] ]
		startingFrom: self session interruptedContext.

	nestedComponents ifNotEmpty: [ 
		aComposite dynamic 
			title: 'Top component';
			display:[ 
				(GTDebuggerInspector new 
					debugger: self;
					startOn: nestedComponents first) ] ].

	(nestedComponents size >= 2) ifTrue: [ 
		aComposite dynamic 
			title: 'Nesting context';
			display:[ 
				(GTDebuggerInspector new  
					debugger: self;
					showFirst: [ :a | 
						a list ];
					startOn: nestedComponents;
					yourself)  ] 
	]
	
]

{ #category : #'building presentations' }
GTSeasideDebugger >> inspectorIn: aComposite [

	(super inspectorIn: aComposite)
		title: 'Inspector'.
	(self requestObjectIn: aComposite).
	(self componentsNestingIn: aComposite)
	
]

{ #category : #'building presentations' }
GTSeasideDebugger >> requestObjectIn: aComposite [
	| requestContext |
	
	requestContext := (self class 
		findContextMatching: [ :ctxt |
			ctxt outerContext isNil and: [ 
				ctxt methodClass = WARequestContext and: [ 
					ctxt methodSelector = #push:during: ] ] ]
		startingFrom: self session interruptedContext).

	requestContext ifNotNil: [ 
		aComposite dynamic 
			title: 'Request context';
			display:[ 
				(GTDebuggerInspector new 
					debugger: self;
					startOn: requestContext receiver).
		"aComposite custom: (GTDebuggerInspector new 
			title: 'Request';
			debugger: self;
			startOn: requestContext receiver ) " ] ] .
	
		
	"requestContext ifNotNil: [ 
		 requestContext gtInspectorRawIn: aComposite.
		 aComposite last title: 'Request context']"
		
]
