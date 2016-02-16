"
I am a custom debugger for SUnit.
I embed a textual diff when an #assert:equals: assertion fails and provide access to the setUp/tearDown methods of a test.

"
Class {
	#name : #GTSUnitDebugger,
	#superclass : #GTGenericStackDebugger,
	#category : #'GT-SUnitDebugger'
}

{ #category : #testing }
GTSUnitDebugger class >> availableAutomatically [
	"Should this debugger be taken into account when looking for a debugger to handle an exception."
	
	^ true
]

{ #category : #accessing }
GTSUnitDebugger class >> defaultTitle [

	^ 'SUnit'
]

{ #category : #testing }
GTSUnitDebugger class >> handlesContext: aContext [
	| activationPredicate |
	activationPredicate := self sessionClass activationPredicate.
	^ (aContext stackOfSize: self lookupStackSize) 
		anySatisfy: [ :ctx | activationPredicate matches: ctx ] 
]

{ #category : #accessing }
GTSUnitDebugger class >> helpClass [
	^ GTSUnitDebuggerHelp
]

{ #category : #testing }
GTSUnitDebugger class >> lookupStackSize [
	^ 10
]

{ #category : #'tools registry' }
GTSUnitDebugger class >> register [

	self registerToolsOn: Smalltalk tools.
]

{ #category : #'tools registry' }
GTSUnitDebugger class >> registerToolsOn: registry [

	"Add ourselves to registry. See [Smalltalk tools]" 
	registry registerDebugger: self withRank: 70.
]

{ #category : #accessing }
GTSUnitDebugger class >> sessionClass [

	^ GTSUnitDebugSession
]

{ #category : #'as yet unclassified' }
GTSUnitDebugger >> browser [ 

	^ self presentations first cachedPresentation ifNotNil: [ :aComposite | aComposite presentations first ]
]

{ #category : #'as yet unclassified' }
GTSUnitDebugger >> compose [
	"give the window a dedicated reddish color to ensure it gets noticed"
	self class enableDebuggerWindowDistinctColor ifTrue: [ 
		self color: (Color r: 1.0 g: 0.3 b: 0.3) ].
	self installDebuggingActionsFor: self.
	self dynamic display: [ :session |
		GLMTabulator new 
			with: [ :browser | 
				self debuggerStructureIn: browser.
				self debuggerTransmissionsIn: browser ];
			startOn: session;
			yourself ].
	self registerActions
]

{ #category : #'accessing context' }
GTSUnitDebugger >> contextToSelectFrom: aSession [
	^ aSession assertionCallerContext ifNil: [ aSession testContext ]
]

{ #category : #building }
GTSUnitDebugger >> debuggerStructureIn: browser [
	
	browser
		row: #stack;
		row: [ :c | c
			column: #code.
			self shouldDisplayExtraCodePane ifTrue: [ 
				c column: #test ] ] span: 2;
		row: #inspector.
		
]

{ #category : #building }
GTSUnitDebugger >> debuggerTransmissionsIn: browser [

	super debuggerTransmissionsIn: browser.
	
	self shouldDisplayExtraCodePane ifTrue: [ 
		browser transmit
			from: #stack port: #selection;
			to: #test;
			andShow: [ :aComposite :aContext | 
				self setUpCodeIn: aComposite.
				self tearDownCodeIn: aComposite ] ]

]

{ #category : #'building presentations' }
GTSUnitDebugger >> inspectorDiffIn: aComposite [

	^ aComposite tabulator 
		with: [ :aTabulator |
			aTabulator when: [ self session supportsDiff].
			aTabulator 
				column: #actual;
				column: #expected.
			aTabulator transmit to: #actual; andShow: [ :anotherComposite |
				anotherComposite  dynamic 
					display: [:anObject |
				 		(GTDebuggerInspector new 
							startOn: self session actualResult) ] ].
			aTabulator transmit to: #expected; andShow: [ :anotherComposite |
				anotherComposite  dynamic 
					display: [:anObject |
				 		(GTDebuggerInspector new 
							startOn: self session expectedResult) ] ] ]
]

{ #category : #'building presentations' }
GTSUnitDebugger >> inspectorIn: aComposite [

	(self textualDiffIn: aComposite) title: 'Diff (actual vs. expected)'.
	(self inspectorDiffIn: aComposite) title: 'Objects (actual vs. expected)'.
	super inspectorIn: aComposite.
	self session supportsDiff ifTrue: [ 
		aComposite last title: 'Inspector' ]
]

{ #category : #'as yet unclassified' }
GTSUnitDebugger >> session [
 
	^ self entity
]

{ #category : #'as yet unclassified' }
GTSUnitDebugger >> session: aSession [
	self startOn: aSession.
	self title: aSession name
]

{ #category : #'building presentations' }
GTSUnitDebugger >> setUpCodeIn: aComposite [

	aComposite pharoMethod
		title: 'SetUp';
		format: [ self session setUpMethod sourceCode ];
		smalltalkClass: [  self session testObject class ];
		when: [ self session overridesDefaultSetUpMethod ];
		doItReceiver: [ self session testObject ].
]

{ #category : #building }
GTSUnitDebugger >> shouldDisplayExtraCodePane [

	^ self session overridesDefaultSetOrTearMethods
]

{ #category : #'building presentations' }
GTSUnitDebugger >> tearDownCodeIn: aComposite [

	aComposite pharoMethod
		title: 'TearDown';
		format: [ self session tearDownMethod sourceCode ];
		smalltalkClass: [  self session testObject class ];
		when: [ self session overridesDefaultTearDownMethod ];
		doItReceiver: [ self session testObject ].
]

{ #category : #'building presentations' }
GTSUnitDebugger >> textualDiffIn: composite [

	^ composite diff
			when: [ self session supportsDiff];
			display: [ 
				{self session actualResult gtDebuggerSUnitPrint. self session expectedResult gtDebuggerSUnitPrint} ]
]

{ #category : #updating }
GTSUnitDebugger >> updateBrowser [

	super updateBrowser.
	"The transmission will select the context of the test case. 
	This should only happen the first time.
	Should find another solution so this method doesn;t have to be overridden"
	((self browser paneNamed: #stack) port: #selection) value: self session interruptedContext
]
