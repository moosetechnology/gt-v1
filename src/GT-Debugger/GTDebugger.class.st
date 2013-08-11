"
GTDebugger is a browser that provides Smalltalk debugging functionality.
 
An example: 
[ GTDebugger debugProcess: Processor activeProcess.
	Processor activeProcess suspend.
	#(1 2 3 4 5) do: [:each | each asString]
] fork.
"
Class {
	#name : #GTDebugger,
	#superclass : #GLMCompositePresentation,
	#category : #'GT-Debugger'
}

{ #category : #'instance creation' }
GTDebugger class >> debugBasedOnSession: aSession [

	^ self debugSession: ((self spanNewSessionForContext: aSession context fromProcess: aSession process)
		errorWasInUIProcess: aSession errorWasInUIProcess)
]

{ #category : #'instance creation' }
GTDebugger class >> debugContext: aContext fromProcess: aProcess [

	^ self debugSession: (self spanNewSessionForContext: aContext fromProcess: aProcess)
]

{ #category : #'instance creation' }
GTDebugger class >> debugProcess: aProcess [

	^ self debugContext: aProcess suspendedContext fromProcess: aProcess
]

{ #category : #'instance creation' }
GTDebugger class >> debugSession: aSession [

	<primitive: 19> "simulation guard"

	"WorldState addDeferredUIMessage: ["
		^ self openOn: aSession 
	"]"
]

{ #category : #accessing }
GTDebugger class >> defaultTitle [
	^ 'Glamorous Debugger'
]

{ #category : #testing }
GTDebugger class >> handlesContext: aContext [

	^ true
]

{ #category : #'instance creation' }
GTDebugger class >> openOn: anObject [ 
	^ self new openOn: anObject
]

{ #category : #'tools registry' }
GTDebugger class >> registerToolsOn: registry [

	"Add ourselves to registry. See [Smalltalk tools]" 
	registry registerDebugger: self withRank: 3.
]

{ #category : #private }
GTDebugger class >> sessionClass [

	^ DebugSession 
]

{ #category : #accessing }
GTDebugger class >> spanNewSessionForContext: aContext fromProcess: aProcess [

	^ self sessionClass process: aProcess context: aContext 
]

{ #category : #accessing }
GTDebugger class >> spanNewSessionForProcess: aProcess [

	^ self spanNewSessionForContext: aProcess suspendedContext fromProcess: aProcess
]

{ #category : #callbacks }
GTDebugger >> actOnBrowserClosing: ann [
	self session ifNotNil: [ :aSession | aSession terminate ]
]

{ #category : #'building actions' }
GTDebugger >> actionsForPragmas: aSymbolsCollection [

	^ ((self allActionsForPragmas: aSymbolsCollection) select: [ :aDebugAction | 
			aDebugAction appliesToContextCurrentContext ]) 
				collect: [ :aDebugAction | aDebugAction asGlamourAction ]

]

{ #category : #'building actions' }
GTDebugger >> allActionsForPragmas: aSymbolsCollection [
	
	^ aSymbolsCollection 
		inject: OrderedCollection new
		into: [ :currentActions :aSymbol | 
			currentActions 
				addAll: (self session class gtDebuggingActionsForPragma: aSymbol for: self);
				yourself ].


	

]

{ #category : #accessing }
GTDebugger >> browser [ 

	^ self presentations first
]

{ #category : #actions }
GTDebugger >> close [

	self browser close
]

{ #category : #'building actions' }
GTDebugger >> codeActionsPragmas [

	^ { #codeDebuggingAction }
]

{ #category : #building }
GTDebugger >> compose [
	self title: self debuggerTitle.
	self tabulator with: [:browser | 
		self debuggerStructureIn: browser.
		self debuggerTransmissionsIn: browser ].
	self registerActions.

]

{ #category : #'accessing context' }
GTDebugger >> currentContext [

	^self selectedContext 
		ifNil: [ self interruptedContext ] 
		ifNotNil:  [ self selectedContext  ]
]

{ #category : #actions }
GTDebugger >> debug: aContext using: aDebuggerClass [
	| currentSession  |
	
	currentSession := self session.
	self detachSession.
	self browser close.
	currentSession updateContextTo: aContext.
	aDebuggerClass debugBasedOnSession: currentSession
]

{ #category : #building }
GTDebugger >> debuggerStructureIn: browser [
	
	browser
		row: [ :row | 
					row
						column: #stack;
						column: #code ];
		row: #inspector.
		
]

{ #category : #accessing }
GTDebugger >> debuggerTitle [
	
	^ self class defaultTitle 
]

{ #category : #building }
GTDebugger >> debuggerTransmissionsIn: browser [

	browser transmit
		to: #stack;
		andShow: [ :composite | self stackIn: composite ].
	browser transmit
		from: #stack port: #entity;
		to: #stack port: #selection;
		when: [ :session | session notNil ];
		transformed: [:session | session context].
	browser transmit
		from: #stack port: #entity;
		from: #stack port: #selection;
		to: #stack port: #context;
		when: [ :session :context | session notNil ];
		transformed: [ :session :context | session createModelForContext: context ].
	browser transmit
		from: #stack port: #context;
		to: #code;
		andShow: [ :composite | self methodCodeIn: composite ].
	browser transmit
		from: #stack port: #context;
		to: #inspector;
		andShow: [ :composite | self inspectorIn: composite ] 

]

{ #category : #'building actions' }
GTDebugger >> debuggingActionsPragmas [

	^ { #debuggingAction }
]

{ #category : #actions }
GTDebugger >> detachSession [
	self flag: 'why silent value?'.
	(self browser pane port: #entity) silentValue: nil
]

{ #category : #intialization }
GTDebugger >> errorWasInUIProcess: aBoolean [

	self session errorWasInUIProcess: aBoolean
]

{ #category : #'building presentations' }
GTDebugger >> inspectorIn: composite [

	composite custom:
			(GTInspector new first "We use the first actual finder because need to send showFirst: to it"
				noTitle;
				noActions;
				showFirst: [ :a | a custom: (GTDebuggerVariablesBrowser new) ];
				yourself)
	
]

{ #category : #'building actions' }
GTDebugger >> installActionsForRootPragmas: aSymbolsCollection in: aPresentation [

	aPresentation dynamicActions: [ :presentation |
		self actionsForPragmas: (aSymbolsCollection collect: [ :aSymbol | #gt, aSymbol capitalized ]) ] .
	
	aPresentation dynamicActionsOnSelection: [ :presentation |
		self actionsForPragmas: (aSymbolsCollection collect: [ :aSymbol | #gtContext, aSymbol capitalized ]) ] .
]

{ #category : #'building actions' }
GTDebugger >> installCodeActionsFor: aPresentation [
	
	self installActionsForRootPragmas: self codeActionsPragmas in: aPresentation
]

{ #category : #'building actions' }
GTDebugger >> installDebuggingActionsFor: aPresentation [

	self installActionsForRootPragmas: self debuggingActionsPragmas in: aPresentation
]

{ #category : #'accessing context' }
GTDebugger >> interruptedContext [

	^ self session context
]

{ #category : #'building presentations' }
GTDebugger >> methodCodeIn: composite [
	composite smalltalkCode
		doItReceiver: [:contextModel | contextModel receiver ];
		title: 'Source';
		format: #source;
		smalltalkClass: [ :contextModel | contextModel selectedClass ];
		initialize: [ :code | code selectionInterval: (self session selectedCodeRangeForContext: self currentContext) ];
		with: [ :code | self installCodeActionsFor: code ]
]

{ #category : #opening }
GTDebugger >> openFullNoSuspendLabel: aString [
	"TODO: do not ignore the title"
	
	self open.
	"TODO: why is this necessy here? I took it from the current debugger"
	"errorWasInUIProcess := UIManager default spawnNewProcessIfThisIsUI: interruptedProcess"
]

{ #category : #'building presentations' }
GTDebugger >> printStackEntry: aContext [

	^ String streamContents: [:stream | aContext printDebugOn: stream ] 
]

{ #category : #intialization }
GTDebugger >> process: aProcess controller: aController context: aContext [

	self session: (self class spanNewSessionForContext: aContext fromProcess: aProcess)
]

{ #category : #building }
GTDebugger >> registerActions [

	self on: GLMBrowserClosing send: #actOnBrowserClosing: to: self.
	self on: DebugActionExecuted send: #updateBrowser to: self.

]

{ #category : #'accessing context' }
GTDebugger >> selectedContext [

	^ ((self browser paneNamed: #stack) port: #selection) value
]

{ #category : #accessing }
GTDebugger >> selectionInterval [

	^ self selectionIntervalForPane: #code
]

{ #category : #accessing }
GTDebugger >> selectionInterval: anInterval [

	^ ((self browser paneNamed: #code) port: #selectionInterval) value: anInterval
]

{ #category : #accessing }
GTDebugger >> selectionIntervalForPane: aSymbol [

	^ ((self browser paneNamed: aSymbol) port: #selectionInterval) value ifNil: [ ^ 1 to: 0 ]
]

{ #category : #accessing }
GTDebugger >> session [
 
	^ (self browser pane port: #entity) value
]

{ #category : #accessing }
GTDebugger >> session: anObject [

	^ (self browser pane port: #entity) value: anObject
]

{ #category : #'building presentations' }
GTDebugger >> stackIn: composite [
	composite list	
		title: 'Stack';
		"showOnly: 10;"
		display: #stack;
		format: [ :each | self printStackEntry: each];
		with: [ :list | self installDebuggingActionsFor: list ]
]

{ #category : #updating }
GTDebugger >> updateBrowser [
	| browserPane session |
	
	session := self session.
	browserPane := self browser pane.
	(browserPane port: #entity) silentValue: nil.
	(browserPane port: #entity) value: session.
	browserPane update.
]

{ #category : #updating }
GTDebugger >> updateSelectionInterval [

	self selectionInterval: (self session pcRangeForContext:  self selectedContext )
]

{ #category : #callbacks }
GTDebugger >> windowIsClosing [ 
	self announce: GLMBrowserClosing new
]
