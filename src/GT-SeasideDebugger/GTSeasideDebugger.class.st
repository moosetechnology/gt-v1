Class {
	#name : #GTSeasideDebugger,
	#superclass : #GTGenericStackDebugger,
	#category : #'GT-SeasideDebugger'
}

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
GTSeasideDebugger >> inspectorIn: aComposite [

	(super inspectorIn: aComposite)
		title: 'Inspector'.
	(self requestObjectIn: aComposite).
	
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
