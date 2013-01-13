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
GTDebugger class >> debugContext: aContext fromProcess: aProcess [

	<primitive: 19> "simulation guard"

	WorldState addDeferredUIMessage: [
		self openOn: (self sessionClass process: aProcess context: aContext) ].
]

{ #category : #'instance creation' }
GTDebugger class >> debugProcess: aProcess [

	self debugContext: aProcess suspendedContext fromProcess: aProcess
]

{ #category : #'instance creation' }
GTDebugger class >> openOn: anObject [ 
	^ self new openOn: anObject
]

{ #category : #private }
GTDebugger class >> sessionClass [

	^ DebugSession 
]

{ #category : #'building actions' }
GTDebugger >> actOnBrowserClosing: ann [
	self model terminate.
]

{ #category : #private }
GTDebugger >> browser [ 
	^ self presentations first
]

{ #category : #building }
GTDebugger >> compose [
	self title: 'Glamorous Debugger'.
	self tabulator with: [:browser | 
		browser on: GLMBrowserClosing send: #actOnBrowserClosing: to: self.
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
			transformed: [:model | model context].
		browser transmit
			from: #stack port: #selection;
			fromOutsidePort: #entity;
			to: #stack port: #context;
			transformed: [ :context :model | model createModelForContext: context ].
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
			transformed: [ :context :model :pc | model selectedCodeRange: context ].
		browser transmit
			from: #stack port: #context;
			to: #inspector;
			andShow: [ :composite | self inspectorForContextAndSelfIn: composite ] ]
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
GTDebugger >> installDebuggingActionsFor: aPresentation [
	self installRestartActionFor: aPresentation.
	self installStepIntoActionFor: aPresentation.
	self installStepOverActionFor: aPresentation.
	self installStepThroughActionFor: aPresentation.
	self installRunToHereActionFor: aPresentation.
	self installResumeActionFor: aPresentation
]

{ #category : #'building actions' }
GTDebugger >> installRestartActionFor: aPresentation [ 
	aPresentation 
		act: [ :presentation :model |
			model restart: self selectedContext.
			self selectTopOfStack: model context  ]
		icon: GLMUIThemeExtraIcons glamorousRestart
		entitled: 'Restart'
]

{ #category : #'building actions' }
GTDebugger >> installResumeActionFor: aPresentation [
	aPresentation 
		act: [ :presentation :model |
			model resume.
			model clear.
			self browser close. ]
		icon: GLMUIThemeExtraIcons glamorousPlay
		entitled: 'Resume' 
]

{ #category : #'building actions' }
GTDebugger >> installRunToHereActionFor: aPresentation [
	aPresentation 
		act: [ :presentation :model | 
			self selectionInterval ifNotNil: [:selectionInterval | 
				model runToSelection: selectionInterval inContext: self selectedContext.
				self selectTopOfStack: model context 	] ]
		icon: GLMUIThemeExtraIcons glamorousPlay
		entitled: 'Run to Here' 
]

{ #category : #'building actions' }
GTDebugger >> installStepIntoActionFor: aPresentation [ 
	aPresentation 
		act: [ :presentation :model |
			model stepInto: self selectedContext.
			self selectTopOfStack: model context ]
		icon: GLMUIThemeExtraIcons glamorousInto
		entitled: 'Step into' 
]

{ #category : #'building actions' }
GTDebugger >> installStepOverActionFor: aPresentation [
	aPresentation 
		act: [ :presentation :model |
			model stepOver: self selectedContext.
			self selectTopOfStack: model context ]
		icon: GLMUIThemeExtraIcons glamorousOver
		entitled: 'Step over' 
]

{ #category : #'building actions' }
GTDebugger >> installStepThroughActionFor: aPresentation [
	aPresentation 
		act: [ :presentation :model |
			model stepThrough: self selectedContext.
			self selectTopOfStack: model context ]
		icon: GLMUIThemeExtraIcons glamorousThrough
		entitled: 'Step through' 
]

{ #category : #private }
GTDebugger >> keyAsFormatedString: key [

	^ [ Text fromString: (key asString contractTo: 50) ]
			on: Error
			do: [ Text string: 'error printing' attribute: TextColor red ] 
]

{ #category : #building }
GTDebugger >> methodCodeIn: composite [
	composite smalltalkCode
		act: [:text :contextModel | 
				| recompilationContext newMethod |				
				(recompilationContext := contextModel locateClosureHome) isNil ifFalse: [
					newMethod := self model recompileMethodTo: text text inContext: recompilationContext.
					newMethod isNil ifFalse: [ self selectTopOfStack: self model context ] ] ]
			icon: GLMUIThemeExtraIcons glamorousAccept 
			on: $s
			entitled: 'Accept';
		act: [ self selectionInterval: (self model pcRangeForContext:  self selectedContext ) ]
			icon: GLMUIThemeExtraIcons glamorousSearch 
			on: $w
			entitled: 'Accept';
		doItReceiver: [:contextModel | contextModel receiver ];
		title: 'Source';
		format: #sourceText;
		smalltalkClass: [ :contextModel | contextModel selectedClass ]
]

{ #category : #accessing }
GTDebugger >> model [
	^ (self browser pane port: #entity) value
]

{ #category : #private }
GTDebugger >> selectTopOfStack: aContext [
	| stackPane |
	stackPane := self browser paneNamed: #stack.
	(stackPane port: #selection) value: aContext.
	(stackPane port: #pc) value: aContext pc.
	stackPane update
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
GTDebugger >> valueAsFormatedString: value [

	^ [ Text fromString: value printString]
			on: Error
			do: [ Text string: 'error printing' attribute: TextColor red ] 
]
