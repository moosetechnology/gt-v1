Class {
	#name : #GTObjectCentricDebugger,
	#superclass : #GTDebugger,
	#instVars : [
		'watcher'
	],
	#category : #'GT-ObjectCentricDebugger'
}

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
			
			watcher isNil ifTrue: [  
				watcher := ([
					Transcript crShow: 'Started'.
					[model process isTerminated 
						ifTrue: [
							Transcript crShow: 'terminated'.
							model clear.
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
			
			model resume.
			"browser close"]
		icon: GLMUIThemeExtraIcons glamorousPlay
		entitled: '-> Message'
]

{ #category : #'as yet unclassified' }
GTObjectCentricDebugger >> updateWithContext: newContext fromProcess: aProcess [
	Transcript crShow: 'GTDebugger>>doSomethingElse: newContext with: aProcess'.	
	Transcript crShow: '    Processor activeProcess : ', Processor activeProcess name.
	Transcript crShow: '    UIManager default : ',UIManager default uiProcess name.
	Transcript crShow: '    aProcess name: ', aProcess name.
	Transcript crShow: '    self model process: ', self model process name.
	"self halt."
	
	watcher isNil ifFalse: [watcher terminate.  watcher :=nil].	
	
	UIManager default spawnNewProcessIfThisIsUI: aProcess.
	
	WorldState
		addDeferredUIMessage: [ 
			Transcript crShow: 'GTDebugger -- addDeferredUIMessage:'.	
			Transcript crShow: '    Processor activeProcess : ', Processor activeProcess name.
			Transcript crShow: '    UIManager default : ',UIManager default uiProcess name.
			Transcript crShow: '    aProcess name: ', aProcess name.
			Transcript crShow: '    self model process: ', self model process name.
			
			self model process: aProcess.
			
			Transcript crShow: '    self model process: ', self model process name.
	
			self model unwindTo: newContext.
			self model process stepToSendOrReturn.
			
			self selectTopOfStack: self model context].
		
	aProcess suspend.
	
]
