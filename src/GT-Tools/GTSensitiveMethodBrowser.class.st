"
self openOn: (GLMEditor>>#createResultBrowserWithBindings:andScript:)
"
Class {
	#name : #GTSensitiveMethodBrowser,
	#superclass : #GLMBrowserTemplate,
	#category : #'GT-Tools-Prototypes'
}

{ #category : #building }
GTSensitiveMethodBrowser >> buildBrowser [ 
	browser := GLMTabulator new.
	
	browser column: #source; column: #preview.
	browser transmit to: #source; andShow: [:a |
		a smalltalkCode
			title: 'Source';
			smalltalkClass: [ :anObject | anObject methodClass ];
			display: [:anObject | anObject getSource ]].
	browser transmit to: #preview; from: #source port: #selectionInterval; fromOutsidePort: #entity; andShow:[:a | 
		a text
			display: [:interval :method |
				self mostSpecificInterestingNodeIn: method atPosition: interval];
			selectionAct: [:each | each displayValue inspect] on: $i;
			selectionAct: [:each | each displayValue explore] on: $I entitled: 'Explore' 
			].
	^ browser
]

{ #category : #private }
GTSensitiveMethodBrowser >> mostSpecificInterestingNodeIn: aMethod atPosition: anInterval [

	| parseTree nodesIncludingInterval |
	parseTree := aMethod parseTree annotateInClass: GLMEditor.
	nodesIncludingInterval := parseTree allChildren select: [ :each | 
		each start <= anInterval first and: [
			each stop >= anInterval first ]].
	^ nodesIncludingInterval reverse 
		detect: [ :each | 
			each isMessage  ] 
		ifNone: [ nil ]
]
