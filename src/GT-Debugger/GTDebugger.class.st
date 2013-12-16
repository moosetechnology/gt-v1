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
	#classVars : [
		'AlwaysOpenFullDebugger',
		'ErrorRecursion',
		'FilterCommonMessageSends',
		'LogDebuggerStackToFile',
		'LogFileName'
	],
	#category : #'GT-Debugger'
}

{ #category : #'settings api' }
GTDebugger class >> alwaysOpenFullDebugger [
	^ AlwaysOpenFullDebugger ifNil: [AlwaysOpenFullDebugger := false]
]

{ #category : #'settings api' }
GTDebugger class >> alwaysOpenFullDebugger: aBoolean [
	AlwaysOpenFullDebugger := aBoolean.
]

{ #category : #'utilities api' }
GTDebugger class >> closeAllDebuggers [
	"GTDebugger closeAllDebuggers"
	(SystemWindow allSubInstances select: [:w | 
		 w model isKindOf: GTDebugger])
			do: [:w | w delete ]
]

{ #category : #'instance creation api' }
GTDebugger class >> context: aContext [
	"Answer an instance of me for debugging the active process starting with the given context."

	^ self new
		process: Processor activeProcess
		controller: nil
		context: aContext
		
]

{ #category : #'instance creation' }
GTDebugger class >> debugBasedOnSession: aSession [

	^ self debugSession: ((self spanNewSessionForContext: aSession context fromProcess: aSession process)
		errorWasInUIProcess: aSession errorWasInUIProcess)
]

{ #category : #'instance creation' }
GTDebugger class >> debugContext: aContext fromProcess: aProcess [

	^ self debugSession: (self spanNewSessionForContext: aContext fromProcess: aProcess)
]

{ #category : #'instance creation api' }
GTDebugger class >> debugError: anError [
	"Handle an otherwise unhandled error"

	self
		openOn: Processor activeProcess
		context: anError signalerContext
		label: anError description
		contents: nil
		fullView: false
]

{ #category : #'instance creation' }
GTDebugger class >> debugSession: aSession [

	<primitive: 19> "simulation guard"

	"WorldState addDeferredUIMessage: ["
		^ self openOn: aSession 
	"]"
]

{ #category : #'settings api' }
GTDebugger class >> defaultLogFileName [
	^ 'PharoDebug.log'
]

{ #category : #accessing }
GTDebugger class >> defaultTitle [
	^ 'Glamorous Debugger'
]

{ #category : #'settings api' }
GTDebugger class >> filterCommonMessageSends [
	self flag: 'horrible hack not to break the setting browser'.
	^ false
]

{ #category : #'settings api' }
GTDebugger class >> filterCommonMessageSends: aBoolean [
	FilterCommonMessageSends := aBoolean
]

{ #category : #testing }
GTDebugger class >> handlesContext: aContext [

	^ true
]

{ #category : #'instance creation api' }
GTDebugger class >> informExistingDebugger: aContext label: aString [
	"Walking the context chain, we try to find out if we're in a debugger stepping situation.
	If we find the relevant contexts, we must rearrange them so they look just like they would
	if the methods were excuted outside of the debugger."
	| ctx quickStepMethod oldSender baseContext |
	ctx := thisContext.
	quickStepMethod := ContextPart compiledMethodAt: #quickSend:to:with:super:.
	[ctx sender == nil or: [ctx sender method == quickStepMethod]] whileFalse: [ctx := ctx sender].
	ctx sender == nil ifTrue: [^self].
	baseContext := ctx.
	"baseContext is now the context created by the #quickSend... method."
	oldSender := ctx := ctx sender home sender.
	"oldSender is the context which originally sent the #quickSend... method"
	[ctx isNil or: [ctx receiver isKindOf: self]] whileFalse: [ctx := ctx sender].
	ctx ifNil: [^self].
	"ctx is the context of the Debugger method #doStep" self flag: 'this is not true any more'.
	ctx receiver label: aString.
	baseContext swapSender: baseContext sender sender sender.	"remove intervening contexts"
	thisContext swapSender: oldSender.	"make myself return to debugger"
	ErrorRecursion := false.
	^aContext
]

{ #category : #'as yet unclassified' }
GTDebugger class >> initialize [ 
	
	ErrorRecursion := false.
]

{ #category : #'settings api' }
GTDebugger class >> logDebuggerStackToFile [
	^ LogDebuggerStackToFile ifNil: [LogDebuggerStackToFile := true]
]

{ #category : #'settings api' }
GTDebugger class >> logDebuggerStackToFile: aBoolean [
	 LogDebuggerStackToFile := aBoolean
]

{ #category : #'settings api' }
GTDebugger class >> logFileName [
	^ LogFileName ifNil: [ self defaultLogFileName ] 
]

{ #category : #'settings api' }
GTDebugger class >> logFileName: newName [
	LogFileName := newName
]

{ #category : #'opening api' }
GTDebugger class >> openContext: aContext label: aString contents: contentsStringOrNil [
	"Open a notifier in response to an error, halt, or notify. A notifier view just shows a short view of the sender stack and provides a menu that lets the user open a full debugger."
	
	<primitive: 19> "Simulation guard"
	ErrorRecursion not & self logDebuggerStackToFile ifTrue:
		[Smalltalk logError: aString inContext: aContext].
	  ErrorRecursion ifTrue:[
               ErrorRecursion := false.
               self primitiveError: aString].
	ErrorRecursion := true.
	
	self informExistingDebugger: aContext label: aString.
	(self context: aContext)
		openNotifierContents: contentsStringOrNil
		label: aString.
	ErrorRecursion := false. 
	Processor activeProcess suspend.

]

{ #category : #'opening api' }
GTDebugger class >> openInterrupt: aString onProcess: interruptedProcess [ 
	"Open a notifier in response to an interrupt. An interrupt occurs when
	the user types the interrupt key (cmd-. on Macs, ctrl-c or alt-. on other
	systems) or when the low-space watcher detects that memory is low."
	| debugger |
	<primitive: 19>
	"Simulation guard"
	debugger := self new.
	debugger
		process: interruptedProcess
		controller: nil
		context: interruptedProcess suspendedContext.
	self logDebuggerStackToFile
		ifTrue: [(aString includesSubstring: 'Space')
					& (aString includesSubstring: 'low')
				ifTrue: [Smalltalk
						logError: aString
						inContext: debugger interruptedContext ]].
	^ debugger openNotifierContents: nil label: aString
]

{ #category : #opening }
GTDebugger class >> openOn: anObject [ 
	^ self new openOn: anObject
]

{ #category : #'opening api' }
GTDebugger class >> openOn: process context: context label: title contents: contentsStringOrNil fullView: bool [ 
	"Open a notifier in response to an error, halt, or notify. A notifier view
	just shows a short view of the sender stack and provides a menu that
	lets the user open a full debugger."
	| fullView |
	fullView := (bool or: [self alwaysOpenFullDebugger]).
	
	Smalltalk tools userManager canDebug ifFalse: [ 
		UIManager default spawnNewProcessIfThisIsUI: process.
		process suspend.
		^ self ].
	
	^ UIManager default 
		openDebuggerOn: process 
		context: context 
		label: title 
		contents: contentsStringOrNil 
		fullView: fullView
]

{ #category : #'window color api' }
GTDebugger class >> patchworkUIThemeColor [
	"Answer a default color for UI themes that make use of different colors for Browser, MessageList etc..."

	^ Color lightRed

]

{ #category : #'tools registry' }
GTDebugger class >> register [

	self registerToolsOn: Smalltalk tools.

]

{ #category : #'tools registry' }
GTDebugger class >> registerExtraToolsOn: registry [
	"This adds self in the list of tools that appears in the small debugger"
	registry registerDebugger: self withRank: 3.
]

{ #category : #'tools registry' }
GTDebugger class >> registerToolsOn: registry [
	registry register: self as: #debugger.

]

{ #category : #accessing }
GTDebugger class >> sessionClass [

	^ DebugSession 
]

{ #category : #private }
GTDebugger class >> spanNewSessionForContext: aContext fromProcess: aProcess [

	^ self sessionClass process: aProcess context: aContext 
]

{ #category : #'settings api' }
GTDebugger class >> stackWidgetClass [
	self flag: 'horrible hack not to break the setting browser'.
	^ self
]

{ #category : #callbacks }
GTDebugger >> actOnBrowserClosing: ann [
	self session ifNotNil: [ :aSession | aSession terminate ]
]

{ #category : #'building actions' }
GTDebugger >> actionsForPragmas: aSymbolsCollection [

	^ (self allActionsForPragmas: aSymbolsCollection)
				collect: [ :aDebugAction | aDebugAction asGlamourAction ]

]

{ #category : #'building actions' }
GTDebugger >> allActionsForPragmas: aSymbolsCollection [
	
	^ (self session class 
		debuggingActionsForPragmas: aSymbolsCollection for: self)

	

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

	^ #( codeDebuggingAction )
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
						column: #code span: 2 ]
			span: 2;
		row: #inspector.
		
]

{ #category : #accessing }
GTDebugger >> debuggerTitle [
	
	^ self class defaultTitle 
]

{ #category : #building }
GTDebugger >> debuggerTransmissionsIn: browser [

	browser transmit
		fromOutsideEntityPort;
		to: #stack;
		andShow: [ :composite | self stackIn: composite ].
	browser transmit
		from: #stack port: #entity;
		to: #stack port: #selection;
		when: [ :session | session notNil ];
		transformed: [:session | session context].
	browser transmit
		from: #stack port: #selection;
		to: #code;
		andShow: [ :composite :aContext | self methodCodeIn: composite forContext: aContext ].
	browser transmit
		from: #stack port: #selection;
		to: #inspector;
		andShow: [ :composite | self inspectorIn: composite ] 

]

{ #category : #'building actions' }
GTDebugger >> debuggingActionsPragmas [

	^ #( debuggingAction )
]

{ #category : #actions }
GTDebugger >> detachSession [
	self flag: 'why silent value?'.
	(self browser pane port: #entity) silentValue: nil
]

{ #category : #'old api' }
GTDebugger >> errorWasInUIProcess: aBoolean [

	self session errorWasInUIProcess: aBoolean
]

{ #category : #'building presentations' }
GTDebugger >> inspectorIn: composite [

	^ composite custom:
			(GTInspector new first "We use the first actual finder because need to send showFirst: to it"
				noTitle;
				noActions;
				showFirst: [ :a | a custom: GTDebuggerVariablesBrowser new ];
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
GTDebugger >> methodCodeIn: composite forContext: aContext [

	(self methodCodeWidgetIn: composite forContext: aContext)
		initialize: [ :code | 
			code selectionInterval: (self session selectedCodeRangeForContext: self currentContext) ];
		with: [ :code | self installCodeActionsFor: code ]
]

{ #category : #'building presentations' }
GTDebugger >> methodCodeWidgetIn: composite forContext: aContext [

	^ composite smalltalkCode
		title: 'Source';
		format: [ aContext sourceCode ];
		smalltalkClass: [  aContext methodClass ];
		doItReceiver: [ aContext receiver ];
		doItContext: [  aContext ]
]

{ #category : #opening }
GTDebugger >> openFullNoSuspendLabel: aString [
	"TODO: do not ignore the title"
	
	(self title: aString) open.
	self flag: 'why is this necessy here? I took it from the current debugger'. 
	self errorWasInUIProcess: (UIManager default spawnNewProcessIfThisIsUI: self session interruptedProcess)
]

{ #category : #opening }
GTDebugger >> openNotifierContents: msgString label: label [
	self openFullNoSuspendLabel: label
]

{ #category : #'building presentations' }
GTDebugger >> printStackEntry: aContext [

	^ String streamContents: [:stream | aContext printDebugOn: stream ] 
]

{ #category : #'old api' }
GTDebugger >> proceed: aTopView [ 
	
	self session 
		resume;
		clear.
	self debugger close.
	self updateBrowser

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

{ #category : #'old api' }
GTDebugger >> send [
	
	self session stepInto: self currentContext.
	self updateBrowser.

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

	(self stackWidgetIn: composite)
		with: [ :stackWidget | self installDebuggingActionsFor: stackWidget ]
]

{ #category : #'building presentations' }
GTDebugger >> stackWidgetIn: composite [

	^ composite list	
		title: 'Stack';
		showOnly: 50;
		display: #stack;
		format: [ :each | self printStackEntry: each]
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
