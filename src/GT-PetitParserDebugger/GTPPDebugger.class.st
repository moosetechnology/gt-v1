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
						column: #stack;
						column: [ :column |
							column 
								row: #code;
								row: #stream ] ];
		row: #inspector.
]

{ #category : #'as yet unclassified' }
GTPPDebugger >> debuggerTransmissionsIn: browser [

	super debuggerTransmissionsIn: browser.
	
	browser transmit
		from: #stack port: #entity;
		to: #stream;
		when: [ :aSession | aSession notNil ];
		transformed: [ :aSession | aSession stream ];
		andShow: [ :composite | self streamIn: composite ].
		
	"browser transmit
		from: #stack port: #entity;
		from: #stack port: #selection;
		to: #stream port: #selectionInterval;
		when: [ :aSession :aContext | (aContext notNil & aSession notNil) and: [aSession parseMethodPredicate matches: aContext ] ];
		transformed: [ :aSession :aContext | 1 to: (aSession streamFromContext: aContext) position ]"
	
]

{ #category : #'building actions' }
GTPPDebugger >> debuggingActionsPragmas [

	^ super debuggingActionsPragmas, { #PPDebuggingAction }
]

{ #category : #'as yet unclassified' }
GTPPDebugger >> streamIn: composite [
	
	composite text
		title: 'Stream';
		format: #collection;
		initialize: [ :aPresentation | aPresentation selectionInterval: (1 to: self session stream position) ]
		"with: [ :code | self installCodeActionsFor: code ]"
]
