"
I provide the basic functionality needed to create new debuggers. 
Subclasses should override the following methods:
	debuggerStructureIn: -> provides the structure of the debugger
	debuggerTransmissionsIn: -> creates transmissions between the widgets of a debuggers
	selectedContext 
"
Class {
	#name : #GTMoldableDebugger,
	#superclass : #GLMCompositePresentation,
	#traits : 'GTBrowsingActions',
	#classTraits : 'GTBrowsingActions classTrait',
	#classVars : [
		'EnableDebuggerWindowDistinctColor',
		'EnableStackColoring',
		'GTDebuggerEnabledStatus'
	],
	#category : #'GT-Debugger-UI'
}

{ #category : #testing }
GTMoldableDebugger class >> availableAutomatically [
	"Should this debugger be taken into account when looking for a debugger to handle an exception."
	
	^ false
]

{ #category : #'instance creation' }
GTMoldableDebugger class >> debugSession: aSession [

	<primitive: 19> "simulation guard"

	"WorldState addDeferredUIMessage: ["
		^ self openOn: aSession 
	"]"
]

{ #category : #accessing }
GTMoldableDebugger class >> defaultTitle [
	self subclassResponsability
]

{ #category : #'settings api' }
GTMoldableDebugger class >> enableDebuggerWindowDistinctColor [
	^ EnableDebuggerWindowDistinctColor ifNil: [EnableDebuggerWindowDistinctColor := false]
]

{ #category : #'settings api' }
GTMoldableDebugger class >> enableDebuggerWindowDistinctColor: aBoolean [
	EnableDebuggerWindowDistinctColor := aBoolean.
]

{ #category : #'settings api' }
GTMoldableDebugger class >> enableStackColoring [
	^ EnableStackColoring ifNil: [EnableStackColoring := false]
]

{ #category : #'settings api' }
GTMoldableDebugger class >> enableStackColoring: aBoolean [
	EnableStackColoring := aBoolean.
]

{ #category : #testing }
GTMoldableDebugger class >> handlesContext: aContext [
	self subclassResponsibility 
]

{ #category : #accessing }
GTMoldableDebugger class >> helpClass [

	self subclassResponsibility
]

{ #category : #'settings api' }
GTMoldableDebugger class >> isGTDebuggerEnabled [

	^ GTDebuggerEnabledStatus ifNil: [ GTDebuggerEnabledStatus := Smalltalk tools debugger = self ]
]

{ #category : #'instance creation api' }
GTMoldableDebugger class >> on: aDebugSession [

	^ self new 	
			session: aDebugSession
]

{ #category : #'opening api' }
GTMoldableDebugger class >> openOn: aDebugSession withFullView: aBool [
	
	self openOn: aDebugSession withFullView: aBool andNotification: nil
]

{ #category : #'opening api' }
GTMoldableDebugger class >> openOn: aDebugSession withFullView: aBool andNotification: aString [
	
	| debugger |
	debugger := (Smalltalk tools 
		debuggerDispatcherFor: aDebugSession interruptedContext
		matching: [:aDebugger | aDebugger availableAutomatically ]) 
			ifNil: [ 
				"Use the current debugger"
				self on: aDebugSession ]
			ifNotNil: [ :aDebugger | 
				"Use a custom extension"
				aDebugger on: (aDebugger spanNewSessionFrom: aDebugSession) ].
	
	aBool | self alwaysOpenFullDebugger
		ifTrue: [ debugger openWithFullView ]
		ifFalse: [ debugger openWithNotification: aString]
]

{ #category : #'window color api' }
GTMoldableDebugger class >> patchworkUIThemeColor [
	"Answer a default color for UI themes that make use of different colors for Browser, MessageList etc..."

	^ Color lightRed

]

{ #category : #accessing }
GTMoldableDebugger class >> sessionClass [
	self subclassResponsability
]

{ #category : #'settings api' }
GTMoldableDebugger class >> setGTDebuggerEnabledStatus: aBoolean [
	| oldStatus |
	
	oldStatus := self isGTDebuggerEnabled.
	GTDebuggerEnabledStatus := aBoolean.
	oldStatus ~= GTDebuggerEnabledStatus ifTrue: [ 
		GTDebuggerEnabledStatus 
			ifTrue: [ self register ]
			ifFalse: [ SpecDebugger registerToolsOn: Smalltalk tools ] ]
	
	
]

{ #category : #private }
GTMoldableDebugger class >> spanNewSessionForContext: aContext fromProcess: aProcess [

	^ self sessionClass 
		named: 'temporary name' on: aProcess startedAt: aContext
]

{ #category : #accessing }
GTMoldableDebugger class >> spanNewSessionFrom: anotherSession [

	^ self sessionClass 
		named: anotherSession name 
		on: anotherSession interruptedProcess 
		startedAt: anotherSession interruptedContext
]

{ #category : #private }
GTMoldableDebugger class >> spanNewSessionLabeled: aString forContext: aContext fromProcess: aProcess [

	^ self sessionClass 
		named: aString on: aProcess startedAt: aContext
]

{ #category : #icons }
GTMoldableDebugger class >> taskbarIcon [

	^ Smalltalk ui icons smallDebugIcon
]

{ #category : #callbacks }
GTMoldableDebugger >> actOnBrowserClosing: ann [
	self session ifNotNil: [ :aSession | aSession terminate ]
]

{ #category : #callbacks }
GTMoldableDebugger >> actOnInspectorPaneRemoved: ann [
]

{ #category : #'building actions' }
GTMoldableDebugger >> actionsForPragmas: aSymbolsCollection [

	^ (self allActionsForPragmas: aSymbolsCollection)
				collect: [ :aDebugAction | aDebugAction asGlamourAction ]

]

{ #category : #'building actions' }
GTMoldableDebugger >> allActionsForPragmas: aSymbolsCollection [
	
	^ (self session class 
		debuggingActionsForPragmas: aSymbolsCollection 
		for: self)

	

]

{ #category : #actions }
GTMoldableDebugger >> browseClassRefs [

	self currentContext ifNotNil: [ :aContext || class|
		class := aContext methodClass theNonMetaClass.
		class isTrait 
			ifTrue: [ self systemNavigation browseAllUsersOfTrait: class ]
			ifFalse: [ self systemNavigation browseAllCallsOnClass: class ] ]

]

{ #category : #actions }
GTMoldableDebugger >> browseClassVarRefs [
	"1/17/96 sw: devolve responsibility to the class, so that the code that does the real work can be shared"

	| cls |
	cls := self currentClass.
	(cls notNil and: [cls isTrait not])
		ifTrue: [self systemNavigation  browseClassVarRefs: cls]
]

{ #category : #actions }
GTMoldableDebugger >> browseClassVariables [
	"Browse the class variables of the selected class."
	| cls |
	cls := self currentClass.
	(cls notNil and: [cls isTrait not])
		ifTrue: [self systemNavigation  browseClassVariables: cls]

]

{ #category : #actions }
GTMoldableDebugger >> browseInstVarRefs [
	"1/26/96 sw: real work moved to class, so it can be shared"
	| cls |
	cls := self currentClassOrMetaClass.
	(cls notNil and: [cls isTrait not])
		ifTrue: [self systemNavigation browseInstVarRefs: cls]
]

{ #category : #actions }
GTMoldableDebugger >> browseMessages [
	"Present a menu of all messages sent by the current message. 
	Open a message set browser of all implementors of the message chosen."

	self currentMessageName ifNotNil: [   
		self systemNavigation browseAllImplementorsOf: self currentMessageName ]
]

{ #category : #actions }
GTMoldableDebugger >> browseMethodFull [
	"Create and schedule a full Browser and then select the current class and message."

	self currentClassOrMetaClass ifNotNil: [ 
		Smalltalk tools browser 
			openOnClass: self currentClassOrMetaClass
			selector: self currentMessageName ]
]

{ #category : #actions }
GTMoldableDebugger >> browseSendersOfMessages [
	"Present a menu of the current message, as well as all messages sent by it.  Open a message set browser of all senders of the selector chosen."

	self currentMessageName ifNotNil: [   
		self systemNavigation browseAllSendersOf: self currentMessageName ]
]

{ #category : #actions }
GTMoldableDebugger >> browseVersions [
	"Create and schedule a message set browser on all versions of the 
	currently selected message selector."

	Smalltalk tools versionBrowser browseVersionsForClass: self currentClassOrMetaClass selector: self currentMessageName
]

{ #category : #accessing }
GTMoldableDebugger >> browser [ 

	^ self presentations first
]

{ #category : #actions }
GTMoldableDebugger >> close [

	self browser close
]

{ #category : #building }
GTMoldableDebugger >> compose [
	"give the window a dedicated reddish color to ensure it gets noticed"
	self class enableDebuggerWindowDistinctColor ifTrue: [ 
		self color: (Color r: 1.0 g: 0.3 b: 0.3) ].
	self installDebuggingActionsFor: self.
	self tabulator with: [:browser | 
		self debuggerStructureIn: browser.
		self debuggerTransmissionsIn: browser ].
	self registerActions
]

{ #category : #accessing }
GTMoldableDebugger >> currentClass [

	^ self currentContext methodClass
]

{ #category : #accessing }
GTMoldableDebugger >> currentClassOrMetaClass [

	^ self currentContext methodClass
]

{ #category : #'accessing context' }
GTMoldableDebugger >> currentContext [

	^self selectedContext 
		ifNil: [ self interruptedContext ] 
		ifNotNil:  [ self selectedContext  ]
]

{ #category : #accessing }
GTMoldableDebugger >> currentMessageCategoryName [
	"Answer the name of the message category of the message of the currently selected context."

	^ self currentClass organization categoryOfElement: self currentMessageName
]

{ #category : #accessing }
GTMoldableDebugger >> currentMessageName [

	^ self currentContext methodSelector
]

{ #category : #actions }
GTMoldableDebugger >> debug: aContext using: aDebuggerClass [
	| currentSession newDebugger |
	
	currentSession := self session.
	self detachSession.
	self browser close.
	currentSession updateContextTo: aContext.
	newDebugger := aDebuggerClass on: (aDebuggerClass spanNewSessionFrom: currentSession).
	newDebugger openWithFullView.
	newDebugger window window "Hack to get this working with SpecDebugger"
		position: self window position;
		extent: self window extent
		
]

{ #category : #building }
GTMoldableDebugger >> debuggerStructureIn: browser [
	self subclassResponsability
		
]

{ #category : #building }
GTMoldableDebugger >> debuggerTransmissionsIn: browser [
	self subclassResponsibility 
]

{ #category : #actions }
GTMoldableDebugger >> detachSession [
	self flag: 'why silent value?'.
	(self browser pane port: #entity) silentValue: nil
]

{ #category : #actions }
GTMoldableDebugger >> fileOutMessage [
	"Put a description of the selected message on a file"

	self currentMessageName ifNotNil: [
		Cursor write showWhile:
			[ self currentClassOrMetaClass fileOutMethod: self currentMessageName ] ]
]

{ #category : #protocol }
GTMoldableDebugger >> initialExtent [
"This code was taken from the standard debugger to get the same behavior. Fell free to refactor"

	RealEstateAgent standardWindowExtent y < 400 "a tiny screen" 
		ifTrue: [^ 700@500].
	
	^ [ | w h |
		w := Display width.
		h := Display height.
		(w - (w // 3)) @ (h - (h // 5)) ]
		on: Error
		do: [ 850@600 ]
]

{ #category : #actions }
GTMoldableDebugger >> inspectInstances [
	"Inspect all instances of the selected class."

	self currentClassOrMetaClass ifNotNil: [ :aClass |
		aClass theNonMetaClass inspectAllInstances ]
]

{ #category : #actions }
GTMoldableDebugger >> inspectSubInstances [
	"Inspect all instances of the selected class and all its subclasses"

	self currentClassOrMetaClass ifNotNil: [ :aClass |
		aClass theNonMetaClass inspectSubInstances ]
]

{ #category : #'building actions' }
GTMoldableDebugger >> installActionsForRootPragmas: aSymbolsCollection in: aPresentation [

	aPresentation dynamicActions: [ :presentation |
		self actionsForPragmas: (aSymbolsCollection collect: [ :aSymbol | #gt, aSymbol capitalized ]) ] .
	
	aPresentation dynamicActionsOnSelection: [ :presentation |
		self actionsForPragmas: (aSymbolsCollection collect: [ :aSymbol | #gtContext, aSymbol capitalized ]) ] .
]

{ #category : #'building actions' }
GTMoldableDebugger >> installDebuggingActionsFor: aPresentation [

	self subclassResponsibility
]

{ #category : #'accessing context' }
GTMoldableDebugger >> interruptedContext [

	^ self session context
]

{ #category : #accessing }
GTMoldableDebugger >> interruptedProcess [

	^ self session interruptedProcess
]

{ #category : #actions }
GTMoldableDebugger >> methodHierarchy [
	"Create and schedule a method browser on the hierarchy of implementors."

	self systemNavigation 
			methodHierarchyBrowserForClass: self currentClassOrMetaClass 
			selector: self currentMessageName

]

{ #category : #'scripting opening' }
GTMoldableDebugger >> openOn: anObject [ 
	^ (super openOn: anObject)
		extent: self initialExtent;
		title: self session name;
		yourself
]

{ #category : #building }
GTMoldableDebugger >> registerActions [

	self when: GLMBrowserClosing send: #actOnBrowserClosing: to: self.
	self when: DebugActionExecuted send: #updateBrowserFrom: to: self.
	self when: GLMPaneRemoved send: #actOnInspectorPaneRemoved: to: self.

]

{ #category : #'accessing context' }
GTMoldableDebugger >> selectedContext [
	self subclassResponsibility 
]

{ #category : #accessing }
GTMoldableDebugger >> session [
 
	^ (self browser pane port: #entity) value
]

{ #category : #accessing }
GTMoldableDebugger >> session: aSession [

	(self browser pane port: #entity) value: aSession.
	self title: aSession name
]

{ #category : #accessing }
GTMoldableDebugger >> title [
	
	^ super title 
		ifNil: [ self class defaultTitle ] 
		ifNotNil: [ :aString | aString ] 
]

{ #category : #updating }
GTMoldableDebugger >> updateBrowser [
	| browserPane session |
	
	session := self session.
	browserPane := self browser pane.
	(browserPane port: #entity) silentValue: nil.
	(browserPane port: #entity) value: session.
	browserPane update.
]

{ #category : #updating }
GTMoldableDebugger >> updateBrowserFrom: anAnnouncement [
	
	anAnnouncement action needsUpdate ifTrue: [
		self updateBrowser ]
]

{ #category : #callbacks }
GTMoldableDebugger >> windowIsClosing [ 
	self announce: GLMBrowserClosing new
]
