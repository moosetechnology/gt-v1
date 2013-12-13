Class {
	#name : #GTSUnitDebugger,
	#superclass : #GTDebugger,
	#category : #'GT-SUnitDebugger'
}

{ #category : #accessing }
GTSUnitDebugger class >> defaultTitle [

	^ 'SUnit Debugger'
]

{ #category : #testing }
GTSUnitDebugger class >> handlesContext: aContext [
	self flag: 'this should go to the superclass'.
	^ (aContext findContextMatchingPredicate: self sessionClass activationPredicate) notNil
]

{ #category : #'as yet unclassified' }
GTSUnitDebugger class >> registerToolsOn: registry [

	"Add ourselves to registry. See [Smalltalk tools]" 
	registry registerDebugger: self withRank: 70.
]

{ #category : #'as yet unclassified' }
GTSUnitDebugger class >> sessionClass [

	^ GTSUnitDebugSession
]

{ #category : #building }
GTSUnitDebugger >> debuggerStructureIn: browser [
	
	browser
		row: [ :row | 
					row
						column: #stack;
						column: #code span: 2 ]
			span: 2;
		row: #diff.
]

{ #category : #building }
GTSUnitDebugger >> debuggerTransmissionsIn: browser [

	browser transmit
		fromOutsideEntityPort;
		to: #stack;
		andShow: [ :composite | self stackIn: composite ].
	browser transmit
		from: #stack port: #entity;
		to: #stack port: #selection;
		when: [ :session | session notNil ];
		transformed: [:session | session context].
	browser transmit
		fromOutsideEntityPort;
		to: #stack port: #selection;
		when: [ :session | session notNil ];
		transformed: [:session | session testContext].
	browser transmit
		from: #stack port: #selection;
		to: #code;
		andShow: [ :composite :aContext | self methodCodeIn: composite forContext: aContext ].
	browser transmit
		from: #stack port: #selection;
		to: #diff;
		andShow: [ :composite | 
			(self diffIn: composite) title: 'Actual vs. expected'.
			(self inspectorIn: composite) title: 'Inspector' ] 

]

{ #category : #'building presentations' }
GTSUnitDebugger >> diffIn: composite [

	^ composite diff
			display: [ { 
				self printCollection: self session actualResult asOrderedCollection. 
				self printCollection: self session expectedResult asOrderedCollection }]
]

{ #category : #'as yet unclassified' }
GTSUnitDebugger >> printCollection: aCollection [

	 ^ String streamContents: [ :out | 
			aCollection do: [ :each | 
				out 
					nextPutAll: each printString;
					nextPut: Character cr ]]
]
