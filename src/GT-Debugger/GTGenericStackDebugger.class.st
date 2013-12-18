"
GTGenericStackDebugger is a browser that provides Smalltalk debugging functionality.
 
"
Class {
	#name : #GTGenericStackDebugger,
	#superclass : #GTMoldableDebugger,
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
GTGenericStackDebugger class >> alwaysOpenFullDebugger [
	^ AlwaysOpenFullDebugger ifNil: [AlwaysOpenFullDebugger := false]
]

{ #category : #'settings api' }
GTGenericStackDebugger class >> alwaysOpenFullDebugger: aBoolean [
	AlwaysOpenFullDebugger := aBoolean.
]

{ #category : #'utilities api' }
GTGenericStackDebugger class >> closeAllDebuggers [
	"GTGenericStackDebugger closeAllDebuggers"
	(SystemWindow allSubInstances select: [:w | 
		 w model isKindOf: GTGenericStackDebugger])
			do: [:w | w delete ]
]

{ #category : #'instance creation api' }
GTGenericStackDebugger class >> context: aContext [
	"Answer an instance of me for debugging the active process starting with the given context."

	^ self new
		process: Processor activeProcess
		controller: nil
		context: aContext
		
]

{ #category : #'instance creation api' }
GTGenericStackDebugger class >> debugError: anError [
	"Handle an otherwise unhandled error"

	self
		openOn: Processor activeProcess
		context: anError signalerContext
		label: anError description
		contents: nil
		fullView: false
]

{ #category : #'settings api' }
GTGenericStackDebugger class >> defaultLogFileName [
	^ 'PharoDebug.log'
]

{ #category : #accessing }
GTGenericStackDebugger class >> defaultTitle [
	^ 'Glamorous Debugger'
]

{ #category : #'settings api' }
GTGenericStackDebugger class >> filterCommonMessageSends [
	self flag: 'horrible hack not to break the setting browser'.
	^ false
]

{ #category : #'settings api' }
GTGenericStackDebugger class >> filterCommonMessageSends: aBoolean [
	FilterCommonMessageSends := aBoolean
]

{ #category : #testing }
GTGenericStackDebugger class >> handlesContext: aContext [

	^ true
]

{ #category : #'instance creation api' }
GTGenericStackDebugger class >> informExistingDebugger: aContext label: aString [
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

{ #category : #initialization }
GTGenericStackDebugger class >> initialize [ 
	
	ErrorRecursion := false.
]

{ #category : #'settings api' }
GTGenericStackDebugger class >> logDebuggerStackToFile [
	^ LogDebuggerStackToFile ifNil: [LogDebuggerStackToFile := true]
]

{ #category : #'settings api' }
GTGenericStackDebugger class >> logDebuggerStackToFile: aBoolean [
	 LogDebuggerStackToFile := aBoolean
]

{ #category : #'settings api' }
GTGenericStackDebugger class >> logFileName [
	^ LogFileName ifNil: [ self defaultLogFileName ] 
]

{ #category : #'settings api' }
GTGenericStackDebugger class >> logFileName: newName [
	LogFileName := newName
]

{ #category : #'opening api' }
GTGenericStackDebugger class >> openContext: aContext label: aString contents: contentsStringOrNil [
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
GTGenericStackDebugger class >> openInterrupt: aString onProcess: interruptedProcess [ 
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

{ #category : #'opening api' }
GTGenericStackDebugger class >> openOn: process context: context label: title contents: contentsStringOrNil fullView: bool [ 
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

{ #category : #'tools registry' }
GTGenericStackDebugger class >> register [

	self registerToolsOn: Smalltalk tools.

]

{ #category : #'tools registry' }
GTGenericStackDebugger class >> registerExtraToolsOn: registry [
	"This adds self in the list of tools that appears in the small debugger"
	registry registerDebugger: self withRank: 3.
]

{ #category : #'tools registry' }
GTGenericStackDebugger class >> registerToolsOn: registry [
	registry register: self as: #debugger.

]

{ #category : #accessing }
GTGenericStackDebugger class >> sessionClass [

	^ DebugSession 
]

{ #category : #'settings api' }
GTGenericStackDebugger class >> stackWidgetClass [
	self flag: 'horrible hack not to break the setting browser'.
	^ self
]

{ #category : #'building actions' }
GTGenericStackDebugger >> codeActionsPragmas [

	^ #( codeDebuggingAction )
]

{ #category : #building }
GTGenericStackDebugger >> debuggerStructureIn: browser [
	
	browser
		row: [ :row | 
					row
						column: #stack;
						column: #code span: 2 ]
			span: 2;
		row: #inspector.
		
]

{ #category : #building }
GTGenericStackDebugger >> debuggerTransmissionsIn: browser [

	browser transmit
		fromOutsideEntityPort;
		to: #stack;
		andShow: [ :composite | self stackIn: composite ].
	browser transmit
		from: #stack port: #entity;
		to: #stack port: #selection;
		when: [ :session | session notNil ];
		transformed: [:session | session context].
	browser transmit "need a method call when the selection is changed"
		from: #stack port: #selection;
		to: #stack port: #action;
		transformed: [ :context | self selectionChanged: context ].
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
GTGenericStackDebugger >> debuggingActionsPragmas [

	^ #( debuggingAction )
]

{ #category : #'old api' }
GTGenericStackDebugger >> errorWasInUIProcess: aBoolean [

	self session errorWasInUIProcess: aBoolean
]

{ #category : #'printing/formatting' }
GTGenericStackDebugger >> formatStackEntry: aContext [

	^ Text 
		string: (self printStackEntry: aContext )
		attributes: (self textAttributesForStackEntry: aContext) 
	 
]

{ #category : #'building presentations' }
GTGenericStackDebugger >> inspectorIn: composite [

	^ composite custom:
			(GTInspector new first "We use the first actual finder because need to send showFirst: to it"
				noTitle;
				noActions;
				showFirst: [ :a | a custom: GTDebuggerVariablesBrowser new ];
				yourself)
	
]

{ #category : #'building actions' }
GTGenericStackDebugger >> installCodeActionsFor: aPresentation [
	
	self installActionsForRootPragmas: self codeActionsPragmas in: aPresentation
]

{ #category : #'building actions' }
GTGenericStackDebugger >> installDebuggingActionsFor: aPresentation [

	self installActionsForRootPragmas: self debuggingActionsPragmas in: aPresentation
]

{ #category : #'building presentations' }
GTGenericStackDebugger >> methodCodeIn: composite forContext: aContext [

	(self methodCodeWidgetIn: composite forContext: aContext)
		initialize: [ :code | 
			code selectionInterval: (self session selectedCodeRangeForContext: self currentContext) ];
		with: [ :code | self installCodeActionsFor: code ]
]

{ #category : #'building presentations' }
GTGenericStackDebugger >> methodCodeWidgetIn: composite forContext: aContext [

	^ composite smalltalkCode
		title: 'Source';
		format: [ aContext sourceCode ];
		smalltalkClass: [  aContext methodClass ];
		doItReceiver: [ aContext receiver ];
		doItContext: [  aContext ]
]

{ #category : #opening }
GTGenericStackDebugger >> openFullNoSuspendLabel: aString [
	"TODO: do not ignore the title"
	
	(self title: aString) open.
	"If the debugger is opened as a result of a notification directly from the UI, span another process."
	self errorWasInUIProcess: (UIManager default spawnNewProcessIfThisIsUI: self session interruptedProcess)
]

{ #category : #opening }
GTGenericStackDebugger >> openNotifierContents: msgString label: label [
	self openFullNoSuspendLabel: label
]

{ #category : #'printing/formatting' }
GTGenericStackDebugger >> printStackEntry: aContext [

	^ String streamContents: [:stream | aContext printDebugOn: stream ] 
]

{ #category : #'old api' }
GTGenericStackDebugger >> proceed: aTopView [ 
	
	self session 
		resume;
		clear.
	self debugger close.
	self updateBrowser

]

{ #category : #'accessing context' }
GTGenericStackDebugger >> selectedContext [

	^ ((self browser paneNamed: #stack) port: #selection) value
]

{ #category : #updating }
GTGenericStackDebugger >> selectionChanged: aContext [
]

{ #category : #accessing }
GTGenericStackDebugger >> selectionInterval [

	^ self selectionIntervalForPane: #code
]

{ #category : #accessing }
GTGenericStackDebugger >> selectionInterval: anInterval [

	^ ((self browser paneNamed: #code) port: #selectionInterval) value: anInterval
]

{ #category : #accessing }
GTGenericStackDebugger >> selectionIntervalForPane: aSymbol [

	^ ((self browser paneNamed: aSymbol) port: #selectionInterval) value ifNil: [ ^ 1 to: 0 ]
]

{ #category : #'old api' }
GTGenericStackDebugger >> send [
	
	self session stepInto: self currentContext.
	self updateBrowser.

]

{ #category : #accessing }
GTGenericStackDebugger >> sourceCode: aString [

	^ ((self browser paneNamed: #code) port: #text) value: aString
]

{ #category : #'building presentations' }
GTGenericStackDebugger >> stackIn: composite [

	(self stackWidgetIn: composite)
		with: [ :stackWidget | self installDebuggingActionsFor: stackWidget ]
]

{ #category : #'building presentations' }
GTGenericStackDebugger >> stackWidgetIn: composite [

	^ composite list	
		title: 'Stack';
		showOnly: 50;
		display: #stack;
		format: [ :each | self formatStackEntry: each]
]

{ #category : #'printing/formatting' }
GTGenericStackDebugger >> textAttributesForStackEntry: aContext [

	^ { TextColor black }
]

{ #category : #updating }
GTGenericStackDebugger >> updateSelectionInterval [

	self selectionInterval: (self session pcRangeForContext:  self selectedContext )
]
