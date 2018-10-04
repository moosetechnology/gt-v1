Class {
	#name : #GTObjectCentricDebugger,
	#superclass : #GTDebugger,
	#category : #'GT-ObjectCentricDebugger'
}

{ #category : #'building actions' }
GTObjectCentricDebugger >> installAtStateChangedFor: aPresentation [
	aPresentation
		act: [ :presentation :model |		
			(self shouldAdaptObject: self selectedContext receiver) ifTrue: [
				self selectedContext receiver haltAtStateChangeAndNotify: (WeakSet new add: self ; yourself).
				model resume ] ]
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
			(self shouldAdaptObject: self selectedContext receiver) ifTrue: [
				self selectedContext receiver haltAtNextMessageAndNotify: (WeakSet new add: self ; yourself).
				model resume ] ]
		icon: GLMUIThemeExtraIcons glamorousPlay
		entitled: '-> Message'
]

{ #category : #private }
GTObjectCentricDebugger >> kernelClasses [

	^ {
		Boolean. True. False. BlockClosure. 
		MethodContext. Array. OrderedCollection. Set. 
		IdentitySet. Dictionary. IdentityDictionary. Class. 
		Metaclass. Behavior. SmallInteger. Float. 
		Error. Exception. UndefinedObject. String.
		
		BFBehavioralMetaObject. BFMetaObjectReflectiveMethod
	}
]

{ #category : #events }
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

{ #category : #'building actions' }
GTObjectCentricDebugger >> shouldAdaptObject: anObject [

	"Filter intances of kernelClasses and the kernelClasses themselves."
	((self kernelClasses includes: anObject class) or: [self kernelClasses includes: anObject])	
		ifFalse: [ ^ true].
	
	^ UIManager default confirm: 'The currently selected object is an instance of class "',anObject class asString,'".
	Adapting such objects may lead to unexpected behaviour.
	Are you sure you want to continue?'.
]

{ #category : #private }
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
