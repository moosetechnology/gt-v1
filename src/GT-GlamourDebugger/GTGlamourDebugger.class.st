Class {
	#name : #GTGlamourDebugger,
	#superclass : #GTDebugger,
	#instVars : [
		'glamourBrowser'
	],
	#category : #'GT-GlamourDebugger'
}

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
GTGlamourDebugger >> browserStructureFor: aBrowser in: aComposite [
	
	aComposite roassal 
		title: 'Browser structure';
		painting: [:view :b | 
			aBrowser viewTreeOn: view ]
]

{ #category : #'as yet unclassified' }
GTGlamourDebugger >> browserStructureIn: composite [
	
	composite roassal 
		title: 'Browser structure';
		painting: [:view :b | 
			b viewTreeOn: view ]
]

{ #category : #'as yet unclassified' }
GTGlamourDebugger >> browserTransmissionsFor: browser [
	
	browser transmit
		from: #stack port: #context;
		to: #browser;
		andShow: [ :composite | self browserStructureFor: glamourBrowser in: composite ]
		"transformed: #receiver;
		andShow: [ :composite | self browserStructureIn: composite ] "
]

{ #category : #building }
GTGlamourDebugger >> compose [
	self title: self debuggerTitle.
	self tabulator with: [:browser | 
		self layoutFor: browser.
		self transmissionsFor: browser.
		self browserTransmissionsFor: browser  ].
	self on: GLMBrowserClosing send: #actOnBrowserClosing: to: self.
]

{ #category : #building }
GTGlamourDebugger >> layoutFor: browser [

	browser
			row: [ :row | 
						row
							column: #stack;
							column: #code ];
			row: #browser;
			row: #inspector.
]

{ #category : #'as yet unclassified' }
GTGlamourDebugger >> startOn: aSession [

	glamourBrowser := self class locateBrowserFor: aSession context.
	super startOn: aSession
]

{ #category : #building }
GTGlamourDebugger >> transmissionsFor: browser. [
		
	browser transmit
			to: #stack;
			andShow: [ :composite | self stackIn: composite ].
		browser transmit
			fromOutsidePort: #entity;
			to: #stack port: #selection;
			transformed: [:session | session context].
		browser transmit
			from: #stack port: #selection;
			fromOutsidePort: #entity;
			to: #stack port: #context;
			transformed: [ :context :session | session createModelForContext: context ].
		browser transmit
			from: #stack port: #selection;
			to: #stack port: #pc;
			transformed: #pc.
		browser transmit
			from: #stack port: #selection;
			to: #stack port: #fakePort;
			transformed: [ :value | self updateStackPane].
		browser transmit
			from: #stack port: #context;
			fromOutsidePort: #entity;
			to: #code;
			andShow: [ :composite | self methodCodeIn: composite ].
		browser transmit
			from: #stack;
			fromOutsidePort: #entity;
			from: #stack port: #pc;
			to: #code port: #selectionInterval;
			transformed: [ :context :session :pc | session selectedCodeRangeForContext: context ].
		browser transmit
			from: #stack port: #context;
			to: #inspector;
			andShow: [ :composite | self inspectorForContextAndSelfIn: composite ] 
]
