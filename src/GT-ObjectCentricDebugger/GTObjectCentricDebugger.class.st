Class {
	#name : #GTObjectCentricDebugger,
	#superclass : #GTDebugger,
	#instVars : [
		'watcher'
	],
	#category : #'GT-ObjectCentricDebugger'
}

{ #category : #'as yet unclassified' }
GTObjectCentricDebugger >> createWatcherThreadForModel: aModel [

	watcher isNil ifTrue: [  
		watcher := ([
			Transcript crShow: 'Started'.
			[aModel process isTerminated 
				ifTrue: [
					Transcript crShow: 'terminated'.
					aModel clear.
					browser close.
					Processor activeProcess terminate.
					"also remove the reification"]
				ifFalse: [
					Transcript crShow: 'wait'.
					(Delay forMilliseconds:  100) wait ].
			 false.
			] whileFalse: []. 
		] newProcess priority: Processor userBackgroundPriority).
		watcher resume].

]

{ #category : #'building actions' }
GTObjectCentricDebugger >> installAtStateChangedFor: aPresentation [
"	aPresentation
		act: [ :presentation :model |
			
			self selectedContext receiver haltAtStateChange.
			Smalltalk tools debugger openFull: true.
			
			model resume.
			browser close]
		icon: GLMUIThemeExtraIcons glamorousPlay
		entitled: '-> State'"
]

{ #category : #'building actions' }
GTObjectCentricDebugger >> installDebuggingActionsFor: aPresentation [
	super installDebuggingActionsFor: aPresentation.
	
	self installNextMessageActionFor: aPresentation.
	self installAtStateChangedFor: aPresentation
]

{ #category : #'building actions' }
GTObjectCentricDebugger >> installNextMessageActionFor: aPresentation [
	aPresentation
		act: [ :presentation :model |
			Transcript crShow: 'GTDebugger>>installNextMessageActionFor:'.
			Transcript crShow: '    Processor activeProcess : ', Processor activeProcess name.
			Transcript crShow: '    UIManager default : ',UIManager default uiProcess name.
			Transcript crShow: '    self model process: ', self model process name.
		
			self selectedContext receiver haltAtNextMessageAndNotify: self.
			self createWatcherThreadForModel: model.
			
			model resume ]
		icon: GLMUIThemeExtraIcons glamorousPlay
		entitled: '-> Message'
]

{ #category : #'as yet unclassified' }
GTObjectCentricDebugger >> resetDebuggerWithContext: newContext fromProcess: aProcess [
	"Reset the context and the process associated with this debugger,
	and make sure aProcess is not the UI thread.
	
	This message should be sent in response to an object centric action 
	from within the process that generated the action."
	
	Transcript crShow: 'GTDebugger>>doSomethingElse: newContext with: aProcess'.	
	Transcript crShow: '    Processor activeProcess : ', Processor activeProcess name.
	Transcript crShow: '    UIManager default : ',UIManager default uiProcess name.
	Transcript crShow: '    aProcess name: ', aProcess name.
	Transcript crShow: '    self model process: ', self model process name.
	
	self terminateWatcher.
	
	UIManager default spawnNewProcessIfThisIsUI: aProcess.
	WorldState
		addDeferredUIMessage: [self updateModelWithContext: newContext fromProcess: aProcess].
	aProcess suspend.
	
]

{ #category : #'as yet unclassified' }
GTObjectCentricDebugger >> terminateWatcher [
	watcher isNil ifFalse: [
		watcher isTerminated ifFalse:  [watcher terminate].  
		watcher :=nil]
]

{ #category : #'as yet unclassified' }
GTObjectCentricDebugger >> updateModelWithContext: newContext fromProcess: aProcess [
	"Update the debugger model and reset the selection"

	Transcript crShow: 'GTDebugger -- addDeferredUIMessage:'.	
	Transcript crShow: '    Processor activeProcess : ', Processor activeProcess name.
	Transcript crShow: '    UIManager default : ',UIManager default uiProcess name.
	Transcript crShow: '    aProcess name: ', aProcess name.
	Transcript crShow: '    self model process: ', self model process name.
			
	self model updateWithContext: newContext fromProcess: aProcess.
	self selectTopOfStack: self model context
	
]
