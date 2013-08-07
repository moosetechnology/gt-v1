Class {
	#name : #GTPPDebugger,
	#superclass : #GTDebugger,
	#category : #'GT-PetitParserDebugger'
}

{ #category : #accessing }
GTPPDebugger class >> defaultTitle [

	^ 'PetitParser Debugger'
]

{ #category : #testing }
GTPPDebugger class >> handlesContext: aContext [

	^ aContext locateTopPPParser notNil 
]

{ #category : #'tools registry' }
GTPPDebugger class >> registerToolsOn: registry [

	"Add ourselves to registry. See [Smalltalk tools]" 
	registry registerDebugger: self withRank: 55.
]

{ #category : #'as yet unclassified' }
GTPPDebugger class >> sessionClass [

	^ GTPPDebugSession 
]

{ #category : #'as yet unclassified' }
GTPPDebugger >> debuggerStructureIn: browser [
	
	browser
		row: [ :row | 
					row
						column: #stack span: 2;
						column: [ :column |
							column 
								row: [ :row2 | 
									row2
										column: #code;
										column: #stream ];
								row: #workspace ] span: 3 ];
		row: #inspector.
]

{ #category : #'as yet unclassified' }
GTPPDebugger >> debuggerTransmissionsIn: browser [

	super debuggerTransmissionsIn: browser.
	
	browser transmit
		from: #stack port: #entity;
		to: #stream;
		when: [ :aSession | aSession notNil ];
		andShow: [ :aComposite | self streamIn: aComposite ].
		
	browser transmit
		from: #stack port: #entity;
		to: #workspace;
		when: [ :aSession | aSession notNil ];
		andShow: [ :composite | self workspaceIn: composite ].
	
]

{ #category : #'building actions' }
GTPPDebugger >> debuggingActionsPragmas [

	^ super debuggingActionsPragmas, { #PPDebuggingAction }
]

{ #category : #'as yet unclassified' }
GTPPDebugger >> mapIn: composite [

	self class environment at: #GLMRoassalPresentation ifPresent: [ :cls |
		composite roassal
			title: 'Map';
			useExplicitNotNil;
			painting: [ :view |
				(self production: #start from: self session rootParser class)
					viewAllNamedParsersWithSelection: "(Array with: selector)  " (Array new)  
					previewing: [:eachParser | self sourceCodeFrom: self session rootParser class selector: eachParser name ]
					on: view ] ]	

]

{ #category : #'as yet unclassified' }
GTPPDebugger >> printStackEntry: aContext [

	^ (self session isPPParser: aContext receiver)
		ifTrue: [ 
			String streamContents: [:stream | 
				| str |
				
				stream nextPutAll: aContext receiver class name.
				aContext methodClass == aContext receiver class 
					ifFalse: [
						stream nextPut: $(.
						stream nextPutAll: aContext methodClass name.
						stream nextPut: $) ].
				stream nextPut: $(.
				aContext receiver printNameOn: stream.
				stream nextPut: $).
				stream nextPutAll: '>>'.
				
				str := super printStackEntry: aContext.
				str := str allButFirst: (str indexOf: '>' ifAbsent: [ -1 ]) + 1.
				stream nextPutAll: str ]  ]
		ifFalse: [ super printStackEntry: aContext ]
	
]

{ #category : #'private utilities' }
GTPPDebugger >> production: selector from: class [
	| parser |
	
	parser := class new.
	^ selector isNil 
		ifTrue: [ parser ]
		ifFalse: [ parser productionAt: selector ]
]

{ #category : #'private utilities' }
GTPPDebugger >> sourceCodeFrom: class selector: production [

	^ class ultimateSourceCodeAt: (production ifNil: [ #start ]) ifAbsent: [ String new ]
]

{ #category : #'as yet unclassified' }
GTPPDebugger >> streamIn: composite [
	
	composite text
		title: 'Stream';
		format: [ :aSession | aSession stream collection ];
		initialize: [ :aPresentation | aPresentation selectionInterval: (1 to: self session stream position) ]
		"with: [ :code | self installCodeActionsFor: code ]"
]

{ #category : #'as yet unclassified' }
GTPPDebugger >> workspaceIn: composite [
	
	"self sourceIn: composite."
	"self graphIn: composite."
	self mapIn: composite.
	"self exampleIn: composite.
	self firstIn: composite.
	self followIn: composite."
]
