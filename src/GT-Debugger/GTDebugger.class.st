"
[ GTDebugger debugProcess: Processor activeProcess.
	Processor activeProcess suspend.
	#(1 2 3 4 5) do: [:each | each asString]
] fork.
"
Class {
	#name : #GTDebugger,
	#superclass : #GLMBrowserTemplate,
	#category : #'GT-Debugger'
}

{ #category : #'as yet unclassified' }
GTDebugger class >> debugIn: anArray [

	<primitive: 19> "simulation guard"
	
	
	WorldState addDeferredUIMessage: [ self openOn: anArray ].
]

{ #category : #'instance creation' }
GTDebugger class >> debugProcess: aProcess [

	<primitive: 19> "simulation guard"
	
	WorldState addDeferredUIMessage: [
		self openOn: (GTDebuggerModel process: aProcess) ].
]

{ #category : #'as yet unclassified' }
GTDebugger >> actOnWindowClosing: ann [
	self model terminate.
]

{ #category : #building }
GTDebugger >> buildBrowser [
	browser := GLMTabulator new.
	self installBrowserActions.
	browser title: 'Glamorous Debugger'.
	browser on: GLMWindowClosing send: #actOnWindowClosing: to: self.
	
	browser
		row: [:row| row column: #stack; column: #code];
		row: #inspector span: 2.

	browser transmit to: #stack; andShow: [ :composite |
		composite list 
			title: 'Stack';
			showOnly: 10;
			display: #stack;
			format: [ :each | each methodClass name , '>>' , each methodSelector ] ].
	
	browser transmit fromOutsidePort: #entity; to: #stack port: #selection; transformed: #context.
	
	browser transmit from: #stack port: #selection; fromOutsidePort: #entity; to: #stack port: #context; 
		transformed: [:context :model |  model methodModel: context ].
		
	browser transmit from: #stack port: #selection; to: #stack port: #pc; 
		transformed: #pc.
	
	browser transmit from: #stack port: #context; fromOutsidePort: #entity; to: #code; andShow: [ :composite |
		composite smalltalkCode  
			selectionAct: [:text :model | model evaluate: text selectedText ] on: $; entitled: 'Do (;)';
			selectionAct: [:text :model | (model evaluate: text selectedText) printString ] on: $/ entitled: 'Print (/)';
			selectionAct: [:text :model | (model evaluate: text selectedText) inspect ] on: $' entitled: 'Inspect ('')';
			title: 'Source';
			format: #sourceText;
			smalltalkClass: [ :model | model receiverClass ]].
		
	browser transmit from: #stack; fromOutsidePort: #entity; from: #stack port: #pc; to: #code port: #selectionInterval;
		transformed: [ :context :model :pc | model selectedCodeRange: context ].
	
	browser transmit from: #stack port: #context; to: #inspector; andShow: [ :composite |
		composite dynamic 
			display: [:each | 
				GTInspector new browser 
					noTitle;
					noActions;
					showFirst: [:a | a custom: (GTDebuggerVariablesBrowser new browser startOn: each) ]; 
					startOn: each  ] ]
]

{ #category : #'private building' }
GTDebugger >> installBrowserActions [
	self installRestartAction.
	self installStepIntoAction.
	self installStepOverAction.
	self installStepThroughAction.
	self installResumeAction
]

{ #category : #'private building' }
GTDebugger >> installRestartAction [
	browser 
		act: [ :b :model |
			model restart: self selectedContext.
			self selectTopOfStack: model context  ]
		icon: GLMUIThemeExtraIcons glamorousRestart
		entitled: 'Restart'
]

{ #category : #'private building' }
GTDebugger >> installResumeAction [
	browser 
		act: [ :b :model |
			model resume.
			b close. ]
		icon: GLMUIThemeExtraIcons glamorousPlay
		entitled: 'Resume' 
]

{ #category : #'private building' }
GTDebugger >> installStepIntoAction [
	browser 
		act: [ :b :model |
			model stepInto: self selectedContext.
			self selectTopOfStack: model context ]
		icon: GLMUIThemeExtraIcons glamorousInto
		entitled: 'Step into' 
]

{ #category : #'private building' }
GTDebugger >> installStepOverAction [
	browser 
		act: [ :b :model |
			model stepOver: self selectedContext.
			self selectTopOfStack: model context ]
		icon: GLMUIThemeExtraIcons glamorousOver
		entitled: 'Step over' 
]

{ #category : #'private building' }
GTDebugger >> installStepThroughAction [
	browser 
		act: [ :b :model |
			model stepThrough: self selectedContext.
			self selectTopOfStack: model context ]
		icon: GLMUIThemeExtraIcons glamorousOver
		entitled: 'Step through' 
]

{ #category : #private }
GTDebugger >> keyAsFormatedString: key [

	^ [ Text fromString: (key asString contractTo: 50) ]
			on: Error
			do: [ Text string: 'error printing' attribute: TextColor red ] 
]

{ #category : #accessing }
GTDebugger >> model [
	^ (browser pane port: #entity) value
]

{ #category : #private }
GTDebugger >> selectTopOfStack: aContext [
	| stackPane |
	stackPane := browser paneNamed: #stack.
	(stackPane port: #selection) value: aContext.
	(stackPane port: #pc) value: aContext pc.
	stackPane update
]

{ #category : #accessing }
GTDebugger >> selectedContext [
	^ ((browser paneNamed: #stack) port: #selection) value
]

{ #category : #private }
GTDebugger >> valueAsFormatedString: value [

	^ [ Text fromString: value printString]
			on: Error
			do: [ Text string: 'error printing' attribute: TextColor red ] 
]
