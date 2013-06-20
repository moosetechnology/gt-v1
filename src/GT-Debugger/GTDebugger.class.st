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

{ #category : #'class initialization' }
GTDebugger class >> initialize [ 

	"Add ourselves to registry. See [Smalltalk tools]" 
	Smalltalk tools registerDebugger: self withRank: 3.
]

{ #category : #'instance creation' }
GTDebugger class >> openOn: anObject [ 
	^ self new openOn: anObject
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

{ #category : #actions }
GTDebugger >> actOnBrowserClosing: ann [
	self session ifNotNil: [ :aSession | aSession terminate ]
]

{ #category : #'building actions' }
GTDebugger >> actionsForPragmas: aSymbolsCollection [
	| allActions |

	allActions := self allActionsForPragmas: aSymbolsCollection.
	
	allActions do: [ :aDebugAction |
		aDebugAction debugger: self ]. "should be removed"

	^ (allActions select: [ :aDebugAction | 
			aDebugAction appliesToContextCurrentContext ]) 
				collect: [ :aDebugAction | aDebugAction asGlamourAction  ]



	

]

{ #category : #'building actions' }
GTDebugger >> allActionsForPragmas: aSymbolsCollection [
	
	^ aSymbolsCollection 
		inject: OrderedCollection new
		into: [ :currentActions :aSymbol | 
			currentActions 
				addAll: (self session class gtDebuggerActionsForPragma: aSymbol for: self);
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

{ #category : #building }
GTDebugger >> compose [
	self title: self debuggerTitle.
	self tabulator with: [:browser | 
		browser
			row: [ :row | 
						row
							column: #stack;
							column: #code ];
			row: #inspector.
		browser transmit
			to: #stack;
			andShow: [ :composite | self stackIn: composite ].
		browser transmit
			fromOutsidePort: #entity;
			to: #stack port: #selection;
			transformed: [:session | session context].
		browser transmit
			from: #stack port: #selection;
			fromOutsidePort: #entity;
			to: #stack port: #context;
			transformed: [ :context :session | session createModelForContext: context ].
		browser transmit
			from: #stack port: #selection;
			to: #stack port: #pc;
			transformed: #pc.
		browser transmit
			from: #stack port: #selection;
			to: #stack port: #fakePort;
			transformed: [ :value | "self updateStackToolbar"].
		browser transmit
			from: #stack port: #context;
			fromOutsidePort: #entity;
			to: #code;
			andShow: [ :composite | self methodCodeIn: composite ].
		browser transmit
			from: #stack;
			fromOutsidePort: #entity;
			from: #stack port: #pc;
			to: #code port: #selectionInterval;
			transformed: [ :context :session :pc | session selectedCodeRangeForContext: context ].
		browser transmit
			from: #stack port: #context;
			to: #inspector;
			andShow: [ :composite | self inspectorForContextAndSelfIn: composite ] ].
	self registerActions.

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

{ #category : #accessing }
GTDebugger >> debuggerTitle [
	
	^ self class defaultTitle 
]

{ #category : #accessing }
GTDebugger >> debuggersForContext: aContext [
	"Ungly check to make sure the debugger will work until everything is in the image"
	(Smalltalk tools respondsTo: #debuggersForContext:excluding:) 
		ifTrue: [ ^ (Smalltalk tools debuggersForContext: aContext excluding: self class)]
		ifFalse: [ ^ OrderedCollection new ]

	
]

{ #category : #actions }
GTDebugger >> detachSession [

	(self browser pane port: #entity) silentValue: nil
]

{ #category : #intialization }
GTDebugger >> errorWasInUIProcess: aBoolean [

	self session errorWasInUIProcess: aBoolean
]

{ #category : #building }
GTDebugger >> inspectorForContextAndSelfIn: composite [
	composite dynamic
		display: [ :each | 
			"We use the first actual finder because need to send showFirst: to it"
			GTInspector new first
				noTitle;
				noActions;
				showFirst: [ :a | a custom: (GTDebuggerVariablesBrowser new startOn: each) ];
				startOn: each ]
]

{ #category : #'building actions' }
GTDebugger >> installCodeActionsFor: aPresentation [

	aPresentation dynamicActions: [ :presentation |
		self actionsForPragmas: {#gtCodeDebuggingActions}  ]
]

{ #category : #'building actions' }
GTDebugger >> installDebuggingActionsFor: aPresentation [

	aPresentation dynamicActions: [ :presentation |
		self actionsForPragmas: {#gtDebuggingActions}  ].
	
	aPresentation dynamicActionsOnSelection: [ :presentation |
		self actionsForPragmas: {#gtContextDebuggingAction} ]
]

{ #category : #accessing }
GTDebugger >> interruptedContext [

	^ self session context
]

{ #category : #building }
GTDebugger >> methodCodeIn: composite [
	composite smalltalkCode
		doItReceiver: [:contextModel | contextModel receiver ];
		title: 'Source';
		format: #source;
		smalltalkClass: [ :contextModel | contextModel selectedClass ];
		with: [ :code | self installCodeActionsFor: code ]
]

{ #category : #opening }
GTDebugger >> openFullNoSuspendLabel: aString [
	"TODO: do not ignore the title"
	
	self open.
]

{ #category : #opening }
GTDebugger >> openWith: aRenderer [
	|window|
	
	window := super openWith: aRenderer.
	window 
		width: 1000; 
		height: 600.
	^ window
]

{ #category : #intialization }
GTDebugger >> process: aProcess controller: aController context: aContext [

	self session: (self class spanNewSessionForContext: aContext fromProcess: aProcess)
]

{ #category : #building }
GTDebugger >> registerActions [

	self on: GLMBrowserClosing send: #actOnBrowserClosing: to: self.
	self on: DebugActionExecuted send: #updateStackPane to: self.
	"self on: DebugActionExecuted send: #updateCodePane to: self."
	"self on: DebugActionExecuted send: #updateInspectorPane to: self."

]

{ #category : #private }
GTDebugger >> selectTopOfStack: aContext [
"	| stackPane |
	stackPane := self browser paneNamed: #stack.
	(stackPane port: #selection) value: aContext.
	(stackPane port: #pc) value: aContext pc.
	stackPane update."
]

{ #category : #accessing }
GTDebugger >> selectedContext [
	^ ((self browser paneNamed: #stack) port: #selection) value
]

{ #category : #private }
GTDebugger >> selectionInterval [
	^ ((self browser paneNamed: #code) port: #selectionInterval) value
]

{ #category : #private }
GTDebugger >> selectionInterval: anInterval [
	^ ((self browser paneNamed: #code) port: #selectionInterval) value: anInterval
]

{ #category : #accessing }
GTDebugger >> session [
	^ (self browser pane port: #entity) value
]

{ #category : #accessing }
GTDebugger >> session: anObject [

	^ (self browser pane port: #entity) value: anObject
]

{ #category : #building }
GTDebugger >> stackIn: composite [
	composite list	
		"updateOn: DebugActionExecuted from: [ self announcer ];"
		title: 'Stack';
		"showOnly: 10;"
		display: #stack;
		format: [ :each | String streamContents: [:stream | each printDebugOn: stream ] ];
		with: [ :list | self installDebuggingActionsFor: list ]
]

{ #category : #private }
GTDebugger >> updateCodePane [ 
	| codePane |
	
	codePane := self browser paneNamed: #code.
	codePane update.
	self updateSelectionInterval.
]

{ #category : #private }
GTDebugger >> updateInspectorPane [

]

{ #category : #private }
GTDebugger >> updateSelectionInterval [

	self selectionInterval: (self session pcRangeForContext:  self selectedContext )
]

{ #category : #private }
GTDebugger >> updateStackPane [
	| stackPane |
	
	stackPane := self browser paneNamed: #stack.
	(stackPane port: #selection) silentValue: nil.
	(stackPane port: #selection) value: self interruptedContext.
	stackPane update.
]

{ #category : #events }
GTDebugger >> windowIsClosing [ 
	self announce: GLMBrowserClosing new
]
