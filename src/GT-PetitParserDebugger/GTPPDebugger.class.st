Class {
	#name : #GTPPDebugger,
	#superclass : #GTGenericStackDebugger,
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
GTPPDebugger class >> register [

	self registerToolsOn: Smalltalk tools.
]

{ #category : #'tools registry' }
GTPPDebugger class >> registerToolsOn: registry [

	"Add ourselves to registry. See [Smalltalk tools]" 
	registry registerDebugger: self withRank: 55.
]

{ #category : #private }
GTPPDebugger class >> sessionClass [

	^ GTPPDebugSession 
]

{ #category : #'building presentations' }
GTPPDebugger >> debugViewIn: composite [
	(self session stream root respondsTo: #root)
		ifFalse: [ ^ self ].
	(composite dynamic 
		title: 'Result';
		display: [|resultPresentation|
			resultPresentation := GLMCompositePresentation new.
			self session stream root root gtDebugView: resultPresentation.
			resultPresentation last noTitle.
			resultPresentation ])
]

{ #category : #building }
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

{ #category : #building }
GTPPDebugger >> debuggerTransmissionsIn: browser [

	super debuggerTransmissionsIn: browser.
	
	browser transmit
		from: #stack port: #entity;
		to: #stream;
		when: [ :aSession | aSession notNil ];
		andShow: [ :aComposite | self streamIn: aComposite ].
		
	browser transmit
		from: #stack port: #entity;
		from: #stack port: #selection;
		to: #workspace;
		when: [ :aSession :aContext | (aSession notNil & aContext notNil) and: [ aSession rootParser class inheritsFrom: PPCompositeParser ] ];
		andShow: [ :aComposite :aSession :aContext | self workspaceIn: aComposite forSession: aSession forContext: aContext ].
	
]

{ #category : #'building actions' }
GTPPDebugger >> debuggingActionsPragmas [

	^ super debuggingActionsPragmas, { #PPDebuggingAction }
]

{ #category : #'building presentations' }
GTPPDebugger >> exampleIn: aComposite forSession: aSession forPoduction: aProduction [

	aComposite text
		title: 'Example';
		useExplicitNotNil;
		display: [ (self production: aProduction from: aSession rootParser class) example ];
		act: [:text | text update] icon: GLMUIThemeExtraIcons glamorousRefresh entitled: 'Generate another one'
]

{ #category : #'building presentations' }
GTPPDebugger >> firstIn: aComposite forSession: aSession forPoduction: aProduction [

	aComposite list
		title: 'First';
		useExplicitNotNil;
		display: [ (self production: aProduction from: aSession rootParser class) firstSet ];
		format: [ :parser | parser displayName ]
]

{ #category : #'building presentations' }
GTPPDebugger >> followIn: aComposite forSession: aSession forPoduction: aProduction [
	
	aComposite list
		title: 'Follow';
		useExplicitNotNil;
		format: [ :parser | parser displayName ];
		display: [
			| parser |
			parser := aSession rootParser class new.
			parser followSets
				at: (parser productionAt: aProduction)
				ifAbsent: [ Array with: nil asParser ] ]
]

{ #category : #'building presentations' }
GTPPDebugger >> graphIn: aComposite forSession: aSession forPoduction: aProduction [
	
	aComposite morph
		title: 'Graph';
		useExplicitNotNil;
		display: [ 
			| morph |
			morph := ScrollPane new.
			morph color: Color white.
			morph scroller addMorph: (self production: aProduction from: aSession rootParser class) morphicProduction.
			(morph allMorphs select: [ :each | 
				each class = StringMorph and: [ each color = Color blue ] ]) do: [ :each |
					each on: #click send: #execute to: 
						((GTPPStepToNextNamedProductionAction forDebugger: self)
							production: each contents) ].
			morph ] 
]

{ #category : #'building presentations' }
GTPPDebugger >> inspectorIn: aComposite on: anObject [
	
	super inspectorIn: aComposite on: anObject.
	
	"aComposite last title: 'Inspector'.
	self progressIn: aComposite.
	self tallyIn: aComposite.
	self debugViewIn: aComposite."
	^ aComposite
]

{ #category : #'building actions' }
GTPPDebugger >> installStreamActionsFor: aPresentation [

	self installActionsForRootPragmas: { #PPStreamDebuggingAction } in: aPresentation
]

{ #category : #'building presentations' }
GTPPDebugger >> mapIn: aComposite forSession: aSession forPoduction: aProduction [

	self class environment at: #GLMRoassalPresentation ifPresent: [ :cls |
		aComposite roassal
			title: 'Map';
			useExplicitNotNil;
			painting: [ :view |
				(self production: #start from: aSession rootParser class)
					viewAllNamedParsersWithSelection: (Array with: aProduction)
					previewing: [:eachParser | self sourceCodeFrom: aSession rootParser class selector: eachParser name ]
					on: view ] ]	

]

{ #category : #'printing/formatting' }
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
				str := str allButFirst: (str indexOf: $> ifAbsent: [ -1 ]) + 1.
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
GTPPDebugger >> productionSelectorsFrom: class [

	^ class productionSelectors
]

{ #category : #'building presentations' }
GTPPDebugger >> progressIn: aComposite [ 
	(self session stream stream respondsTo: #asPositionMorph)
		ifFalse: [ ^ self ].
	aComposite morph 
		title: 'Progress';
		display: [
			| morph |
			morph := ScrollPane new.
			morph color: Color white.  
			morph scroller addMorph: self session stream stream asPositionMorph.
			morph ].
]

{ #category : #'private utilities' }
GTPPDebugger >> sourceCodeFrom: class selector: production [

	^ class ultimateSourceCodeAt: (production ifNil: [ #start ]) ifAbsent: [ String new ]
]

{ #category : #'building presentations' }
GTPPDebugger >> sourceIn: aComposite forSession: aSession forPoduction: aProduction [

	aComposite smalltalkCode
		title: 'Source';
		useExplicitNotNil;
		display: [ self sourceCodeFrom: aSession rootParser class selector: aProduction ];
		smalltalkClass: [ aSession rootParser class ]
]

{ #category : #'building presentations' }
GTPPDebugger >> streamIn: composite [
	
	composite text
		title: 'Stream';
		when: [ :aSession | aSession stream notNil ];
		format: [ :aSession | aSession stream collection ];
		initialize: [ :aPresentation | aPresentation 
			selectionInterval: (1 to: (self session stream ifNil: [ 0 ] ifNotNil: [ :aStream | aStream position ])) ];
		with: [ :aPresentation | self installStreamActionsFor: aPresentation ]
]

{ #category : #accessing }
GTPPDebugger >> streamPane [

	^ self browser paneNamed: #stream
]

{ #category : #accessing }
GTPPDebugger >> streamSelectionInterval [

	^ self selectionIntervalForPane: #stream
]

{ #category : #'building presentations' }
GTPPDebugger >> tallyIn: composite [
	(self session stream stream respondsTo: #asFrequencyTable)
		ifFalse: [ ^ self ].
	composite table 
		title: 'Tally';
		column: 'Parser' evaluated: [ :each | each first displayName ];
		column: 'Count' evaluated: [ :each | each second printString ];
		column: 'Percentage (%)' evaluated: [ :each | each third printString ];
		display: [ self session stream stream asFrequencyTable ];
		noSelection;
		showOnly: 50
]

{ #category : #'printing/formatting' }
GTPPDebugger >> textAttributesForStackEntry: aContext [

	(self session isPPProduction: aContext receiver) 
		ifTrue: [ ^ {TextEmphasis bold} ].
		
	(self session rootParserContext  == aContext )
		ifTrue: [ ^ {TextEmphasis italic} ].
		
	^ {TextColor gray}
]

{ #category : #updating }
GTPPDebugger >> updateStreamSelectionInterval [

	(self streamPane port: #selectionInterval) value: (1 to: self session stream position)
]

{ #category : #'building presentations' }
GTPPDebugger >> workspaceIn: aComposite forSession: aSession forContext: aContext [
	| targetParser nameProperty |
	
	targetParser := (aContext locateTopNamedPPParser) 
		ifNil: [ aSession rootParser ] 
		ifNotNil: [ :parserContext | parserContext receiver ].
	nameProperty := targetParser propertyAt: 'name' ifAbsent: [ nil ].
	
	self sourceIn: aComposite forSession: aSession forPoduction: nameProperty.
	self graphIn: aComposite forSession: aSession forPoduction: nameProperty.
	self mapIn: aComposite forSession: aSession forPoduction: nameProperty.
	self exampleIn: aComposite forSession: aSession forPoduction: nameProperty.
	self firstIn: aComposite forSession: aSession forPoduction: nameProperty.
	self followIn: aComposite forSession: aSession forPoduction: nameProperty.
]
