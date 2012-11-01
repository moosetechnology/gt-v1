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

{ #category : #'instance creation' }
GTDebugger class >> debugContext: aContext fromProcess: aProcess [

	<primitive: 19> "simulation guard"

	WorldState addDeferredUIMessage: [
		self openOn: (GTDebuggerModel process: aProcess context: aContext) ].
]

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
GTDebugger >> actOnBrowserClosing: ann [
	self model terminate.
]

{ #category : #building }
GTDebugger >> buildBrowser [
	browser := GLMTabulator new.
	browser title: 'Glamorous Debugger'.
	browser on: GLMBrowserClosing send: #actOnBrowserClosing: to: self.
	
	browser
		row: [:row| row column: #stack; column: #code];
		row: #inspector span: 2.

	browser transmit to: #stack; andShow: [ :composite | |presentation| 
		presentation := composite list 
			title: 'Stack';
			showOnly: 10;
			display: #stack;
			format: [ :each | each methodClass name , '>>' , each methodSelector ].
		self  installBrowserActions: presentation ].
	
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
GTDebugger >> installBrowserActions: aPresentation [
	self installRestartAction: aPresentation.
	self installStepIntoAction: aPresentation.
	self installStepOverAction: aPresentation.
	self installStepThroughAction: aPresentation.
	self installResumeAction: aPresentation 
]

{ #category : #'private building' }
GTDebugger >> installRestartAction: aPresentation [ 
	aPresentation 
		act: [ :presentation :model |
			model restart: self selectedContext.
			self selectTopOfStack: model context  ]
		icon: GLMUIThemeExtraIcons glamorousRestart
		entitled: 'Restart'
]

{ #category : #'private building' }
GTDebugger >> installResumeAction: aPresentation [
	aPresentation 
		act: [ :presentation :model |
			model resume.
			browser close. ]
		icon: GLMUIThemeExtraIcons glamorousPlay
		entitled: 'Resume' 
]

{ #category : #'private building' }
GTDebugger >> installStepIntoAction: aPresentation [ 
	aPresentation 
		act: [ :presentation :model |
			model stepInto: self selectedContext.
			self selectTopOfStack: model context ]
		icon: GLMUIThemeExtraIcons glamorousInto
		entitled: 'Step into' 
]

{ #category : #'private building' }
GTDebugger >> installStepOverAction: aPresentation [
	aPresentation 
		act: [ :presentation :model |
			model stepOver: self selectedContext.
			self selectTopOfStack: model context ]
		icon: GLMUIThemeExtraIcons glamorousOver
		entitled: 'Step over' 
]

{ #category : #'private building' }
GTDebugger >> installStepThroughAction: aPresentation [
	aPresentation 
		act: [ :presentation :model |
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
