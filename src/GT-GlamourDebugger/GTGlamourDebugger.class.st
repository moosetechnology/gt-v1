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

	^ aContext locateBrowserContext notNil 
]

{ #category : #'tools registry' }
GTGlamourDebugger class >> registerToolsOn: registry [

	"Add ourselves to registry. See [Smalltalk tools]" 
	registry registerDebugger: self withRank: 50.
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

{ #category : #testing }
GTGlamourDebugger >> isActive [

	^ rootBrowserContext  
		ifNil: [ false ] 
		ifNotNil: [ 
			rootBrowserContext isDead not and: [
				
				rootBrowserContext ~= self session process suspendedContext or: [rootBrowserContext willReturn not ]
				
				 ]  ]
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

	rootBrowserContext := aSession context locateBrowserContext.
	super startOn: aSession
]
