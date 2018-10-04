Class {
	#name : #ACGlamourDebugger,
	#superclass : #GTGenericStackDebugger,
	#category : #'ACD-Glamour-Interface'
}

{ #category : #accessing }
ACGlamourDebugger class >> defaultTitle [

	^ 'Announcement Centric Debugger'
]

{ #category : #testing }
ACGlamourDebugger class >> handlesContext: aContext [

	 ^ (self sessionClass stackFilterFor: aContext) locateAnnouncerEntryPoint notNil 
]

{ #category : #'tools registry' }
ACGlamourDebugger class >> register [

	self registerToolsOn: Smalltalk tools.
]

{ #category : #'tools registry' }
ACGlamourDebugger class >> registerToolsOn: registry [

	"Add ourselves to registry. See [Smalltalk tools]" 
	registry registerDebugger: self withRank: 10.
]

{ #category : #private }
ACGlamourDebugger class >> sessionClass [

	^ ACDDebugSession 
]

{ #category : #'building presentations' }
ACGlamourDebugger >> announcerIn: composite [

	composite custom:
			(GTInspector new first
				fixedSizePanes: 1; "Only one"
				noTitle;
				noActions;
				showFirst: [ :a | a custom: (ACDAnnouncerBrowser new debugger: self) ];
				yourself)

]

{ #category : #accessing }
ACGlamourDebugger >> announcersBrowser [

	^ ((self browser paneNamed: #announcer) presentations first panes first presentations first) 
]

{ #category : #'building presentations' }
ACGlamourDebugger >> codePresentationIn: aComposite forContext: aContext [

	^ (self methodCodeWidgetIn: aComposite forContext: aContext)
		title: [ GTInspector new printObjectAsAnItem: aContext receiver ];
		act: [:each |  each entity receiver explore] on: $e entitled: 'Explore'
]

{ #category : #'accessing context' }
ACGlamourDebugger >> currentContext [ 

	^ self interruptedContext
]

{ #category : #building }
ACGlamourDebugger >> debuggerStructureIn: browser [
	
	browser
		column: [ :column | 
			column
				row: #receiver;
				row: #announcer;
				row: #sender];
		column: #stack.
]

{ #category : #building }
ACGlamourDebugger >> debuggerTransmissionsIn: browser [
	
	browser transmit
		to: #stack;
		andShow: [ :composite | self stackIn: composite ].
	browser transmit
		from: #stack port: #entity;
		to: #stack port: #currentContext;
		transformed: [ self currentContext ].
			
	browser transmit
		from: #stack port: #currentContext;
		to: #receiver;
		when: [ :session | session notNil ];
		andShow: [ :composite | self receiverIn: composite ].
	browser transmit
		to: #announcer;
		andShow: [ :composite | self announcerIn: composite ].
	browser transmit
		to: #sender;
		andShow: [ :composite | self senderIn: composite ]
]

{ #category : #'building actions' }
ACGlamourDebugger >> installReceiverActionsFor: aPresentation [

	self installActionsForRootPragmas: #(debuggingAction codeDebuggingAction) in: aPresentation
]

{ #category : #'building actions' }
ACGlamourDebugger >> installSenderActionsFor: aPresentation [

	self installActionsForRootPragmas: { #ACDSenderDebuggingAction } in: aPresentation
]

{ #category : #'building actions' }
ACGlamourDebugger >> installStackActionsFor: aPresentation [

	self installActionsForRootPragmas: { #ACDStackDebuggingAction } in: aPresentation
]

{ #category : #'building presentations' }
ACGlamourDebugger >> receiverIn: composite [

	(self codePresentationIn: composite forContext: self session context)
		initialize: [ :code | code selectionInterval: (self session selectedCodeRangeForContext: self currentContext) ];
		with: [ :code | self installReceiverActionsFor: code ].
		
	composite custom:
			((GTInspector new first "We use the first actual finder because need to send showFirst: to it"
				fixedSizePanes: 1;
				showFirst: [ :a | a custom: (GTDebuggerVariablesBrowser new noActions; noTitle) ];
				yourself)
					title: 'State')
]

{ #category : #accessing }
ACGlamourDebugger >> receiverSelectionInterval [

	^ self selectionIntervalForPane: #receiver
]

{ #category : #'accessing context' }
ACGlamourDebugger >> selectedContext [

	^ self interruptedContext
]

{ #category : #accessing }
ACGlamourDebugger >> selectedStackContext [

	^ ((self browser paneNamed: #stack) port: #selection)  value
]

{ #category : #accessing }
ACGlamourDebugger >> selectedSubscription [
	
	^  self announcersBrowser selectedSubscription 
]

{ #category : #'building presentations' }
ACGlamourDebugger >> senderIn: composite [

	(self codePresentationIn: composite forContext: self session senderContext)
		initialize: [ :code | code selectionInterval: (self session selectedCodeRangeForContext: self session senderContext) ];
		with: [ :code | self installSenderActionsFor: code ]
]

{ #category : #'building presentations' }
ACGlamourDebugger >> stackIn: composite [

	(self stackWidgetIn: composite)
		with: [ :code | self installStackActionsFor: code ];
		selectionAct: [:each|  each selection explore] on: $i entitled: 'Explore'

]

{ #category : #'printing/formatting' }
ACGlamourDebugger >> textAttributesForStackEntry: aContext [
	| ctxt |
	(self session receiverContext  == aContext )
		ifTrue: [ ^ {TextEmphasis bold} ].

	(self session senderContext == aContext) 
		ifTrue: [ ^ {TextEmphasis bold} ].
	
	ctxt := aContext findContextSuchThat: [ :aSenderContext |
		(aSenderContext == self session receiverContext) or: [  aSenderContext == self session senderContext ]  ].
	ctxt == self session receiverContext ifTrue: [  ^ {TextColor black} ].
	ctxt == self session senderContext ifTrue: [  ^ {TextColor gray} ].
		
	^ {TextColor black}
]

{ #category : #updating }
ACGlamourDebugger >> updateReceiverCodeSelection [

	((self browser paneNamed: #receiver) 
		port: #selectionInterval) 
			value:  (self session selectedCodeRangeForContext:  self currentContext)
]

{ #category : #updating }
ACGlamourDebugger >> updateSelectionInterval [
	self updateReceiverCodeSelection

]

{ #category : #updating }
ACGlamourDebugger >> updateSenderCodeSelection [

	((self browser paneNamed: #sender) 
		port: #selectionInterval) 
			value:  (self session selectedCodeRangeForContext:  self session senderContext)
]
