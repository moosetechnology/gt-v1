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

{ #category : #building }
GTDebugger >> buildBrowser [
	browser := GLMTabulator new.
	self installBrowserActions.
	browser title: 'Glamorous Debugger'.
	browser
		row: #stack;
		row: #code;
		row: #inspector span: 2.

	browser transmit to: #stack; andShow: [ :composite |
		composite list 
			title: 'Stack';
			showOnly: 10;
			display: #stack;
			format: [ :each | each methodClass name , '>>' , each methodSelector ] ].
	
	browser transmit fromOutsidePort: #entity; to: #stack port: #selection; transformed: #context.
	browser transmit from: #stack port: #selection; to: #stack port: #pc; transformed: #pc.
	
	browser transmit from: #stack; fromOutsidePort: #entity; to: #code; andShow: [ :composite |
		composite text 
			selectionAct: [:text :context :model | model evaluate: text selectedText in: context ] on: $; entitled: 'Do (;)';
			selectionAct: [:text :context :model |
				(model evaluate: text selectedText in: context) printString. ] on: $/ entitled: 'Print (/)';
			selectionAct: [:text :context :model | (model evaluate: text selectedText in: context) inspect ] on: $' entitled: 'Inspect ('')';
			title: 'Source';
			display: [ :context :model | model methodModel: context ];
			format: #sourceText;
			forSmalltalk: [ :context :model | model receiverClass: context ]].
		
	browser transmit from: #stack; fromOutsidePort: #entity; from: #stack port: #pc; to: #code port: #selectionInterval;
		transformed: [ :context :model :pc | model selectedCodeRange: context ].
		
	browser transmit fromOutsidePort: #entity; to: #inspector; andShow: [ :composite |
			composite custom: (GTInspector new browser) ]
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
			"b close."
			model resume ]
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
