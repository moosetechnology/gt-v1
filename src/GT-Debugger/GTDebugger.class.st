"
[ [ 1+ 'a' ] on: Error do: [ :e |
		| ctxtAndProcess |
		ctxtAndProcess := {e signalerContext. Processor activeProcess}.
		self debugIn: ctxtAndProcess ].
	 1 asString.
	 ] fork



| ctxtAndProcess |
[	ctxtAndProcess := {thisContext. Processor activeProcess}.
	self debugIn: ctxtAndProcess.
	Processor activeProcess suspend.
	 1 asString.
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

{ #category : #building }
GTDebugger >> buildBrowser [
	browser := GLMTabulator new.
	self installBrowserActions.
	browser title: 'Glamorous Debugger'.
	browser
		row: #stack;
		row: #code.
	browser transmit to: #stack; andShow: [ :composite |
		composite list 
			title: 'Stack';
			display: [ :array | array first stackOfSize: 100  ];
			format: [ :each | each methodClass name , '>>' , each methodSelector ] ].
		
	browser transmit from: #stack; to: #code; andShow: [ :composite |
		composite text 
			title: 'Source';
			display: [:context | context method debuggerMap sourceText asText ];
			forSmalltalk: [:context | thisContext receiver class ]].
	
	browser transmit fromOutsidePort: #entity; to: #stack port: #selection; transformed: [ :array | (array first stackOfSize: 100) first ]. 
	browser transmit from: #stack port: #selection; toOutsidePort: #selectedContext.  
]

{ #category : #'private building' }
GTDebugger >> installBrowserActions [
	self installRestartAction.
	self installStepIntoAction.
	self installStepOverAction.
]

{ #category : #'private building' }
GTDebugger >> installRestartAction [
	browser 
		act: [ :b :array |  
			| ctxt selectedContext |
			selectedContext := (b pane port: #selectedContext) value.
			ctxt := array second popTo: selectedContext.
			ctxt == selectedContext ifTrue: [
				array second restartTop; stepToSendOrReturn ].
			b entity: { ctxt . array second } inspect ]
		icon: GLMUIThemeExtraIcons glamorousRestart
		entitled: 'Restart'
]

{ #category : #'private building' }
GTDebugger >> installStepIntoAction [
	browser 
		act: [ :b :array |  
			| newContext |
			newContext := array last "process" step: array first.
			newContext := array last stepToSendOrReturn.
			Transcript print: newContext; cr; print: newContext pc; flush.
			b entity: {newContext. array second} ]
		icon: GLMUIThemeExtraIcons glamorousInto
		entitled: 'Step into' 
]

{ #category : #'private building' }
GTDebugger >> installStepOverAction [
	browser 
		act: [ :b :array |  
			| newContext |
			newContext := array last "process" completeStep: array first.
			newContext == array first "context" ifTrue: [
				newContext := array last stepToSendOrReturn ].
			Transcript print: newContext; cr; print: newContext pc; flush.
			b entity: {newContext. array second} ]
		icon: GLMUIThemeExtraIcons glamorousOver
		entitled: 'Step over' 
]
