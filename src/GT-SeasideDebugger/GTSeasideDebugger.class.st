"
I am extension of the GTDebugger for the Seaside web framework.

I am a work in progress. Currently I display information about the  context and the chain of components present in the call stack.

I can be used if the class size method #handlesContext: returns true when called with the interrupted context of the process handling the Seaside request.
"
Class {
	#name : #GTSeasideDebugger,
	#superclass : #GTGenericStackDebugger,
	#category : #'GT-SeasideDebugger'
}

{ #category : #query }
GTSeasideDebugger class >> collectContextMatching: aBlock until: aTerminationBlock startingFrom: aContext [
	| collectedContexts |
	
	collectedContexts := OrderedCollection new.
	self 
		forContextMatching: aBlock 
		do: [ :ctxt | collectedContexts add: ctxt ] 
		until: aTerminationBlock 
		startingFrom: aContext.
	^ collectedContexts
]

{ #category : #accessing }
GTSeasideDebugger class >> defaultTitle [

	^ 'Seaside'
]

{ #category : #query }
GTSeasideDebugger class >> findContextMatching: aBlock startingFrom: aContext [
	
	self
		forContextMatching: aBlock 
		do: [ :ctxt | ^ ctxt ] 
		until: [ :ctxt | false ] 
		startingFrom: aContext.
	^ nil
]

{ #category : #query }
GTSeasideDebugger class >> forContextMatching: aBlock do: anActionBlock until: aTerminationBlock startingFrom: aContext [
	| currentContext counter |
	
	currentContext := aContext.
	counter := 1.
	[ currentContext notNil 
		and: [counter < self lookupStackSize 
			and: [ (aTerminationBlock value: currentContext) not ] ] ] 
		whileTrue: [
			(aBlock value: currentContext) ifTrue: [ 
				anActionBlock value: currentContext ].
			currentContext := currentContext sender.
			counter := counter + 1 ].
]

{ #category : #testing }
GTSeasideDebugger class >> handlesContext: aContext [ 
	
	^ (self 
		findContextMatching: [ :ctxt | 
			ctxt methodClass = WARequestHandler and: [
				ctxt methodSelector = #handle: ] ] 
		startingFrom: aContext) notNil
]

{ #category : #accessing }
GTSeasideDebugger class >> lookupStackSize [
	^ 9999
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

	nestedComponents := self nestedContexts collect: #receiver.

	"nestedComponents ifNotEmpty: [ 
		self topComponent: nestedComponents first in: aComposite ]."

	(nestedComponents size >= 2) ifTrue: [ 
		self nestedComponents: nestedComponents in: aComposite  ]
	
]

{ #category : #'building presentations' }
GTSeasideDebugger >> inspectorIn: aComposite [

	(super inspectorIn: aComposite)
		title: 'Inspector'.
	(self requestObjectIn: aComposite).
	(self componentsNestingIn: aComposite)
	
]

{ #category : #'building presentations' }
GTSeasideDebugger >> nestedComponents: nestedComponents in: aComposite [ 

	^ aComposite dynamic 
		title: 'Nesting context';
		display:[ 
			(GTDebuggerInspector new  
				debugger: self;
				showFirst: [ :a | 
					a list ];
				startOn: nestedComponents;
				yourself) ]
	
]

{ #category : #accessing }
GTSeasideDebugger >> nestedContexts [
	|collectedContexts|
	collectedContexts := OrderedCollection new.
	self class
		forContextMatching: [ :ctxt |
			ctxt methodClass inheritsFrom: WAComponent ] 
		do: [ :ctxt | 
			collectedContexts size == 0 
				ifTrue: [collectedContexts add: ctxt]
				ifFalse: [ collectedContexts last methodClass = ctxt methodClass ifFalse: [ 
					collectedContexts add: ctxt ] ]  ]
		until: [ :ctxt |
			ctxt outerContext isNil and: [ 
				ctxt methodClass = WASession and: [ 
					ctxt methodSelector = #start ] ] ]
		startingFrom: self session interruptedContext.
	^ collectedContexts
]

{ #category : #accessing }
GTSeasideDebugger >> requestContext [

	^ (self class 
		findContextMatching: [ :ctxt |
			ctxt outerContext isNil and: [ 
				ctxt methodClass = WARequestContext and: [ 
					ctxt methodSelector = #push:during: ] ] ]
		startingFrom: self session interruptedContext)
		
]

{ #category : #'building presentations' }
GTSeasideDebugger >> requestObjectIn: aComposite [
	| requestContext |
	
	requestContext := self requestContext.
	requestContext ifNotNil: [ 
		aComposite dynamic 
			title: 'Request context';
			display:[ 
				(GTDebuggerInspector new 
					debugger: self;
					startOn: requestContext receiver) ] ] 
]

{ #category : #'as yet unclassified' }
GTSeasideDebugger >> stackComponentsIn: composite [
	|nestedContexts|
	nestedContexts := self nestedContexts.
	^ composite fastTable	
		title: 'Components stack';
		display: [:aSession | (self retrieveStackFrom: aSession) select: [:ctxt |
			nestedContexts anySatisfy: [:targetContext | targetContext methodClass = ctxt methodClass ]]];
		column: 'Class' 
			evaluated: [ :aContext | self formatStackClassColumnForContext: aContext]
			width: 300;
		column: 'Method' 
			evaluated: [ :aContext | self formatStackMethodColumnForContext: aContext ];
		column: 'Other' 
			evaluated: [ :aContext | self formatStackExtraColumnForContext: aContext ];
		hideHeader
]

{ #category : #'as yet unclassified' }
GTSeasideDebugger >> stackIn: composite [

	super stackIn: composite.
	self stackComponentsIn: composite.
	^ composite
]

{ #category : #'building presentations' }
GTSeasideDebugger >> topComponent: aComponent in: aComposite [ 

	aComposite dynamic 
		title: 'Top component';
		display:[ 
			(GTDebuggerInspector new 
				debugger: self;
				startOn: aComponent) ]
	
]
