"
GTMoldableDebugger provides the basic functionality needed to create new debuggers. 
Subclasses should override the following methods:
	debuggerStructureIn: -> provides the structure of the debugger
	debuggerTransmissionsIn: -> creates transmissions between the widgets of a debuggers
	selectedContext 
"
Class {
	#name : #GTMoldableDebugger,
	#superclass : #GLMCompositePresentation,
	#category : #'GT-Debugger'
}

{ #category : #'instance creation' }
GTMoldableDebugger class >> debugBasedOnSession: aSession [

	^ self debugSession: ((self spanNewSessionForContext: aSession context fromProcess: aSession process)
		errorWasInUIProcess: aSession errorWasInUIProcess)
]

{ #category : #'instance creation' }
GTMoldableDebugger class >> debugContext: aContext fromProcess: aProcess [

	^ self debugSession: (self spanNewSessionForContext: aContext fromProcess: aProcess)
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

{ #category : #testing }
GTMoldableDebugger class >> handlesContext: aContext [
	self subclassResponsibility 
]

{ #category : #opening }
GTMoldableDebugger class >> openOn: anObject [ 
	^ self new openOn: anObject
]

{ #category : #'window color api' }
GTMoldableDebugger class >> patchworkUIThemeColor [
	"Answer a default color for UI themes that make use of different colors for Browser, MessageList etc..."

	^ Color lightRed

]

{ #category : #'tools registry' }
GTMoldableDebugger class >> registerToolsOn: registry [
	self subclassResponsibility 
]

{ #category : #accessing }
GTMoldableDebugger class >> sessionClass [
	self subclassResponsability
]

{ #category : #private }
GTMoldableDebugger class >> spanNewSessionForContext: aContext fromProcess: aProcess [

	^ self sessionClass process: aProcess context: aContext 
]

{ #category : #callbacks }
GTMoldableDebugger >> actOnBrowserClosing: ann [
	self session ifNotNil: [ :aSession | aSession terminate ]
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
	self tabulator with: [:browser | 
		self debuggerStructureIn: browser.
		self debuggerTransmissionsIn: browser ].
	self registerActions.

]

{ #category : #'accessing context' }
GTMoldableDebugger >> currentContext [

	^self selectedContext 
		ifNil: [ self interruptedContext ] 
		ifNotNil:  [ self selectedContext  ]
]

{ #category : #actions }
GTMoldableDebugger >> debug: aContext using: aDebuggerClass [
	| currentSession  |
	
	currentSession := self session.
	self detachSession.
	self browser close.
	currentSession updateContextTo: aContext.
	aDebuggerClass debugBasedOnSession: currentSession
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

{ #category : #'building actions' }
GTMoldableDebugger >> installActionsForRootPragmas: aSymbolsCollection in: aPresentation [

	aPresentation dynamicActions: [ :presentation |
		self actionsForPragmas: (aSymbolsCollection collect: [ :aSymbol | #gt, aSymbol capitalized ]) ] .
	
	aPresentation dynamicActionsOnSelection: [ :presentation |
		self actionsForPragmas: (aSymbolsCollection collect: [ :aSymbol | #gtContext, aSymbol capitalized ]) ] .
]

{ #category : #'accessing context' }
GTMoldableDebugger >> interruptedContext [

	^ self session context
]

{ #category : #intialization }
GTMoldableDebugger >> process: aProcess controller: aController context: aContext [

	self session: (self class spanNewSessionForContext: aContext fromProcess: aProcess)
]

{ #category : #building }
GTMoldableDebugger >> registerActions [

	self on: GLMBrowserClosing send: #actOnBrowserClosing: to: self.
	self on: DebugActionExecuted send: #updateBrowser to: self.

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
GTMoldableDebugger >> session: anObject [

	^ (self browser pane port: #entity) value: anObject
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

{ #category : #callbacks }
GTMoldableDebugger >> windowIsClosing [ 
	self announce: GLMBrowserClosing new
]
