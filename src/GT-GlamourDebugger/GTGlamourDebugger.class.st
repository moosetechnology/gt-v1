Class {
	#name : #GTGlamourDebugger,
	#superclass : #GTDebugger,
	#instVars : [
		'rootBrowserContext'
	],
	#category : #'GT-GlamourDebugger'
}

{ #category : #'as yet unclassified' }
GTGlamourDebugger class >> defaultTitle [
	^ 'Glamour Debugger'
]

{ #category : #testing }
GTGlamourDebugger class >> handlesContext: aContext [

	^ (self locateBrowserContextFor: aContext ) notNil 
]

{ #category : #'class initialization' }
GTGlamourDebugger class >> initialize [ 

	"Add ourselves to registry. See [Smalltalk tools]" 
	Smalltalk tools registerDebugger: self withRank: 50.
]

{ #category : #'as yet unclassified' }
GTGlamourDebugger class >> locateBrowserContextFor: aContext [
	
	^ (aContext findContextSuchThat:  [ :ctx | 
		ctx receiver isGlamourBrowser and: [ ctx selector = #startOn: ] ]) 
]

{ #category : #'as yet unclassified' }
GTGlamourDebugger class >> locateBrowserFor: aContext [

	^ (self locateBrowserContextFor: aContext) receiver
]

{ #category : #'as yet unclassified' }
GTGlamourDebugger >> browserStructureFor: aGlmBrowser in: aComposite [
	
	aComposite roassal 
		title: 'Browser structure';
		painting: [:view :b | 
			aGlmBrowser viewTreeOn: view ]
]

{ #category : #'as yet unclassified' }
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

{ #category : #'as yet unclassified' }
GTGlamourDebugger >> rootBrowser [

	^ rootBrowserContext receiver
]

{ #category : #'as yet unclassified' }
GTGlamourDebugger >> rootBrowserContext [

	^ rootBrowserContext
]

{ #category : #'as yet unclassified' }
GTGlamourDebugger >> startOn: aSession [

	rootBrowserContext := self class locateBrowserContextFor: aSession context.
	super startOn: aSession
]
