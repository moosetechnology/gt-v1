Class {
	#name : #GTGlamourDebugger,
	#superclass : #GTDebugger,
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

{ #category : #private }
GTGlamourDebugger class >> sessionClass [

	^ GTGlamourDebugSession
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
		from: #stack port: #selection;
		to: #browser;
		andShow: [ :composite | self browserStructureFor: self session rootBrowser in: composite ]
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
