Class {
	#name : #GTObjectCentricDebugger,
	#superclass : #GTDebugger,
	#category : #'GT-ObjectCentricDebugger'
}

{ #category : #'building actions' }
GTObjectCentricDebugger >> installAtStateChangedFor: aPresentation [
	aPresentation
		act: [ :presentation :model |		
			self selectedContext receiver haltAtStateChangeAndNotify: (WeakSet new add: self ; yourself).
			model resume ]
		icon: GLMUIThemeExtraIcons glamorousPlay
		entitled: '-> State'
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
			Transcript crShow: 'GTObjectCentricDebugger>>installNextMessageActionFor:'.
			Transcript crShow: '    Processor activeProcess : ', Processor activeProcess name.
			Transcript crShow: '    UIManager default : ',UIManager default uiProcess name.
			Transcript crShow: '    self model process: ', self model process name.
		
			self selectedContext receiver haltAtNextMessageAndNotify: (WeakSet new add: self ; yourself).
			model resume. ]
		icon: GLMUIThemeExtraIcons glamorousPlay
		entitled: '-> Message'
]

{ #category : #'as yet unclassified' }
GTObjectCentricDebugger >> resetDebuggerWithContext: newContext fromProcess: aProcess [
	"Reset the context and the process associated with this debugger,
	and make sure aProcess is not the UI thread.
	
	This message should be sent in response to an object centric action 
	from within the process that generated the action."
	
	Transcript crShow: 'GTObjectCentricDebugger>>resetDebuggerWithContext: newContext fromProcess: aProcess'.	
	Transcript crShow: '    Processor activeProcess : ', Processor activeProcess name.
	Transcript crShow: '    UIManager default : ',UIManager default uiProcess name.
	Transcript crShow: '    aProcess name: ', aProcess name.
	Transcript crShow: '    self model process: ', self model process name.
	
	UIManager default spawnNewProcessIfThisIsUI: aProcess.
	WorldState
		addDeferredUIMessage: [self updateModelWithContext: newContext fromProcess: aProcess].
	aProcess suspend.
	
]

{ #category : #'as yet unclassified' }
GTObjectCentricDebugger >> updateModelWithContext: newContext fromProcess: aProcess [
	"Update the debugger model and reset the selection"

	Transcript crShow: 'GTObjectCentricDebugger>>updateModelWithContext: newContext fromProcess: aProcess'.	
	Transcript crShow: '    Processor activeProcess : ', Processor activeProcess name.
	Transcript crShow: '    UIManager default : ',UIManager default uiProcess name.
	Transcript crShow: '    aProcess name: ', aProcess name.
	Transcript crShow: '    self model process: ', self model process name.
			
	self model updateWithContext: newContext fromProcess: aProcess.
	self selectTopOfStack: self model context
	
]
