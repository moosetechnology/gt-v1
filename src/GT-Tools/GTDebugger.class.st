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
	#category : #'GT-Tools'
}

{ #category : #'as yet unclassified' }
GTDebugger class >> debugIn: anArray [

	<primitive: 19> "simulation guard"
	
	
	WorldState addDeferredUIMessage: [ self openOn: anArray ].
]

{ #category : #'as yet unclassified' }
GTDebugger >> buildBrowser [
	browser := GLMTabulator new.
	self installBrowserActions.
	browser
		row: #stack;
		row: #code.
	browser transmit to: #stack; andShow: [ :composite |
		composite list 
			display: [ :array | array first stackOfSize: 100  ];
			format: [ :each | each methodClass name , '>>' , each methodSelector ] ].
		
	browser transmit from: #stack; to: #code; andShow: [ :composite |
		composite text display: [:context | context method debuggerMap sourceText asText ]].
	
	browser transmit fromOutsidePort: #entity; to: #stack port: #selection; transformed: [ :array | (array first stackOfSize: 100) first ]. 
	browser transmit from: #stack port: #selection; toOutsidePort: #selectedContext.  
]

{ #category : #'as yet unclassified' }
GTDebugger >> installBrowserActions [
	self installRestartAction.
	self installStepIntoAction.
	self installStepOverAction.
]

{ #category : #'as yet unclassified' }
GTDebugger >> installRestartAction [
	browser 
		act: [ :b :array |  
			| ctxt selectedContext |
			selectedContext := (b pane port: #selectedContext) value.
			ctxt := array second popTo: selectedContext.
			ctxt == selectedContext ifTrue: [
				array second restartTop; stepToSendOrReturn ].
			b entity: { ctxt . array second } inspect ]
		icon: GLMUIThemeExtraIcons glamorousLeft
		entitled: 'restart'
]

{ #category : #'as yet unclassified' }
GTDebugger >> installStepIntoAction [
	browser 
		act: [ :b :array |  
			| newContext |
			newContext := array last "process" step: array first.
			newContext := array last stepToSendOrReturn.
			Transcript print: newContext; cr; print: newContext pc; flush.
			b entity: {newContext. array second} ]
		icon: GLMUIThemeExtraIcons glamorousDown
		entitled: 'step into' 
]

{ #category : #'as yet unclassified' }
GTDebugger >> installStepOverAction [
	browser 
		act: [ :b :array |  
			| newContext |
			newContext := array last "process" completeStep: array first.
			newContext == array first "context" ifTrue: [
				newContext := array last stepToSendOrReturn ].
			Transcript print: newContext; cr; print: newContext pc; flush.
			b entity: {newContext. array second} ]
		icon: GLMUIThemeExtraIcons glamorousRight
		entitled: 'step over' 
]
