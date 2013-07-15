Class {
	#name : #GTGlamourDebugger,
	#superclass : #GTDebugger,
	#instVars : [
		'rootBrowserContext'
	],
	#category : #'GT-GlamourDebugger'
}

{ #category : #accessing }
GTGlamourDebugger class >> defaultTitle [
	^ 'Glamour Debugger'
]

{ #category : #testing }
GTGlamourDebugger class >> handlesContext: aContext [

	^ (self locateBrowserContextFor: aContext) notNil 
]

{ #category : #accessing }
GTGlamourDebugger class >> locateBrowserContextFor: aContext [

	^ self stackFilter locateBrowserContextFor: aContext
]

{ #category : #'tools registry' }
GTGlamourDebugger class >> registerToolsOn: registry [

	"Add ourselves to registry. See [Smalltalk tools]" 
	registry registerDebugger: self withRank: 50.
]

{ #category : #accessing }
GTGlamourDebugger class >> stackFilter [

	^ GTGlamourStackFilter 
]

{ #category : #building }
GTGlamourDebugger >> browserStructureFor: aGlmBrowser in: aComposite [
	
	aComposite roassal 
		title: 'Browser structure';
		painting: [:view :b | 
			aGlmBrowser viewTreeOn: view ]
]

{ #category : #building }
GTGlamourDebugger >> browserTransmissionsIn: browser [
	
	browser transmit
		from: #stack port: #context;
		to: #browser;
		andShow: [ :composite | self browserStructureFor: self rootBrowser in: composite ]
]

{ #category : #building }
GTGlamourDebugger >> debuggerStructureIn: browser [

	browser
			row: [ :row | 
						row
							column: [ :c |
								c
									row: #stack;
									row: #code ];
							column: #browser ] span: 4;
			row: #inspector span: 3.
]

{ #category : #building }
GTGlamourDebugger >> debuggerTransmissionsIn: browser. [
		
	super debuggerTransmissionsIn: browser.
	self browserTransmissionsIn: browser.
]

{ #category : #'building actions' }
GTGlamourDebugger >> debuggingActionsPragmas [

	^ super debuggingActionsPragmas, { #glamourDebuggingAction }
]

{ #category : #accessing }
GTGlamourDebugger >> rootBrowser [

	^ rootBrowserContext receiver
]

{ #category : #accessing }
GTGlamourDebugger >> rootBrowserContext [

	^ rootBrowserContext
]

{ #category : #'scripting opening' }
GTGlamourDebugger >> startOn: aSession [

	rootBrowserContext := self class locateBrowserContextFor: aSession context.
	super startOn: aSession
]
