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

{ #category : #'as yet unclassified' }
GTDebugger class >> handlesContext: aContext [

	^ true
]

{ #category : #'class initialization' }
GTDebugger class >> initialize [ 
	super initialize.

	"Add ourselves to registry. See [Smalltalk tools]" 
	Smalltalk tools registerDebugger: self.
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
GTDebugger >> addChangeDebuggerActionFor: aPresentation to: aCollection [
	
	(self debuggersForContext: self selectedContext)
		do: [ :aDebuggerClass | 
			aCollection
				add:
					(GLMGenericAction new
						action: [ self debug: self selectedContext using: aDebuggerClass ];
						title: aDebuggerClass defaultTitle;
						category: 'Available Debuggers';
						yourself) ]
]

{ #category : #'building actions' }
GTDebugger >> addCreateMessageActionFor: aPresentation to: aCollection [

	(self session isInterruptedContextDoesNotUnderstand and: [self session context = self selectedContext]) ifTrue: [ 
		aCollection add:
			((GLMGenericAction new) 
				action: [ :presentation :session |
					session createMethodInContext: self selectedContext.
					self selectTopOfStack: session context.
					self updateCodePane ]; 
				icon: GLMUIThemeExtraIcons glamorousAdd;
				title: 'Create method';
				yourself) ]
]

{ #category : #accessing }
GTDebugger >> browser [ 
	^ self presentations first
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
	self on: GLMBrowserClosing send: #actOnBrowserClosing: to: self.
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
	self installWhereIsActionFor: aPresentation.
	self installRunToHereActionFor: aPresentation.
	self installSaveActionFor: aPresentation.
]

{ #category : #'building actions' }
GTDebugger >> installDebuggingActionsFor: aPresentation [
	self installRestartActionFor: aPresentation.
	self installStepIntoActionFor: aPresentation.
	self installStepOverActionFor: aPresentation.
	self installStepThroughActionFor: aPresentation.
	self installResumeActionFor: aPresentation.
	self installDynamicActionsFor: aPresentation.
]

{ #category : #'building actions' }
GTDebugger >> installDynamicActionsFor: aPresentation [
	
	aPresentation dynamicActionsOnSelection: [ :presentation || newActions |
		newActions := OrderedCollection new.
		self addCreateMessageActionFor: aPresentation to: newActions.
		self addChangeDebuggerActionFor: aPresentation to: newActions.
		newActions ]
]

{ #category : #'building actions' }
GTDebugger >> installRestartActionFor: aPresentation [ 
	aPresentation 
		act: [ :presentation :session |
			session restart: self selectedContext.
			self selectTopOfStack: session context  ]
		icon: GLMUIThemeExtraIcons glamorousRestart
		entitled: 'Restart'
]

{ #category : #'building actions' }
GTDebugger >> installResumeActionFor: aPresentation [
	aPresentation 
		act: [ :presentation :session |
			session resume.
			session clear.
			self browser close. ]
		icon: GLMUIThemeExtraIcons glamorousPlay
		entitled: 'Resume' 
]

{ #category : #'building actions' }
GTDebugger >> installRunToHereActionFor: aPresentation [
	aPresentation 
		act: [ :text :contextModel | 
			self selectionInterval ifNotNil: [:selectionInterval | 
				self session runToSelection: selectionInterval inContext: self selectedContext.
				self selectTopOfStack: self session context 	] ]
		icon: GLMUIThemeExtraIcons glamorousPlay
		entitled: 'Run to Here' 
]

{ #category : #'building actions' }
GTDebugger >> installSaveActionFor: aPresentation [ 
	aPresentation 
		act: [ :text :contextModel | 			
			 (self session recompileMethodTo: text text inContext: self selectedContext)
				 ifNotNil: [ 
					self selectTopOfStack: self session context.
					self updateCodePane ] ] 
		icon: GLMUIThemeExtraIcons glamorousAccept 
		on: $s
		entitled: 'Accept'
]

{ #category : #'building actions' }
GTDebugger >> installStepIntoActionFor: aPresentation [ 
	aPresentation 
		act: [ :presentation :session |
			session stepInto: self selectedContext.
			self selectTopOfStack: session context ]
		icon: GLMUIThemeExtraIcons glamorousInto
		entitled: 'Step into' 
]

{ #category : #'building actions' }
GTDebugger >> installStepOverActionFor: aPresentation [
	aPresentation 
		act: [ :presentation :session |
			session stepOver: self selectedContext.
			self selectTopOfStack: session context ]
		icon: GLMUIThemeExtraIcons glamorousOver
		entitled: 'Step over' 
]

{ #category : #'building actions' }
GTDebugger >> installStepThroughActionFor: aPresentation [
	aPresentation 
		act: [ :presentation :session |
			session stepThrough: self selectedContext.
			self selectTopOfStack: session context ]
		icon: GLMUIThemeExtraIcons glamorousThrough
		entitled: 'Step through' 
]

{ #category : #'building actions' }
GTDebugger >> installWhereIsActionFor: aPresentation [ 
	aPresentation 
		act: [ :text :contextModel | 
			self updateSelectionInterval ]
		icon: GLMUIThemeExtraIcons glamorousSearch 
		on: $w
		entitled: 'Where is?'
]

{ #category : #building }
GTDebugger >> methodCodeIn: composite [
	composite smalltalkCode
		doItReceiver: [:contextModel | contextModel receiver ];
		title: 'Source';
		format: #sourceText;
		smalltalkClass: [ :contextModel | contextModel selectedClass ];
		with: [ :code | self installCodeActionsFor: code ]
]

{ #category : #opening }
GTDebugger >> openFullNoSuspendLabel: aString [
	"TODO: do not ignore the title"
	
	self open.
]

{ #category : #intialization }
GTDebugger >> process: aProcess controller: aController context: aContext [

	self session: (self class spanNewSessionForContext: aContext fromProcess: aProcess)
]

{ #category : #private }
GTDebugger >> selectTopOfStack: aContext [
	| stackPane |
	stackPane := self browser paneNamed: #stack.
	(stackPane port: #selection) value: aContext.
	(stackPane port: #pc) value: aContext pc.
	stackPane update.
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
		title: 'Stack';
		showOnly: 10;
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
GTDebugger >> updateSelectionInterval [

	self selectionInterval: (self session pcRangeForContext:  self selectedContext )
]

{ #category : #events }
GTDebugger >> windowIsClosing [ 
	self announce: GLMBrowserClosing new
]
