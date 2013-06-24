Class {
	#name : #GTGlamourDebugger,
	#superclass : #GTDebugger,
	#instVars : [
		'glamourBrowser'
	],
	#category : #'GT-GlamourDebugger'
}

{ #category : #'as yet unclassified' }
GTGlamourDebugger class >> defaultTitle [
	^ 'Glamour Debugger'
]

{ #category : #testing }
GTGlamourDebugger class >> handlesContext: aContext [

	^ aContext receiver isGlamourBrowser
]

{ #category : #'class initialization' }
GTGlamourDebugger class >> initialize [ 

	"Add ourselves to registry. See [Smalltalk tools]" 
	Smalltalk tools registerDebugger: self withRank: 50.
]

{ #category : #'as yet unclassified' }
GTGlamourDebugger class >> locateBrowserFor: aContext [

	^ (aContext findContextSuchThat:  [ :ctx | ctx receiver isGlamourBrowser ]) receiver
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
		andShow: [ :composite | self browserStructureFor: glamourBrowser in: composite ]
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
GTGlamourDebugger >> startOn: aSession [

	glamourBrowser := self class locateBrowserFor: aSession context.
	super startOn: aSession
]
