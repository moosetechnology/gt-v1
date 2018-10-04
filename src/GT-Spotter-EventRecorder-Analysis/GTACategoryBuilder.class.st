Class {
	#name : #GTACategoryBuilder,
	#superclass : #Object,
	#instVars : [
		'builder',
		'collection',
		'sessionsPerInterest',
		'yBlock',
		'eventSelectionBlock',
		'sortBlock',
		'eventName',
		'dataName'
	],
	#category : #'GT-Spotter-EventRecorder-Analysis-Roassal-Category'
}

{ #category : #building }
GTACategoryBuilder >> build [
	| maxPoints |
	self buildSessionsPerInterestDataSet.
	"self buildSelectionEventDataSet."
	"self buildActOnOrCloseEventDataSet."
	maxPoints := builder datasets max: [ :set | set points size ].
	builder extent: (maxPoints * 30 min: 800) @ 150.
	builder axisX
		noTick;
		noLabel.
	builder axisY.
	builder build.
	^ builder view
]

{ #category : #building }
GTACategoryBuilder >> buildSessionsPerInterestDataSet [
	| ds points |
	points := self sessionsPerInterest.
	points ifEmpty: [ ^ builder view ].
	ds := RTStackedDataSet new.
	ds interaction highlight.
	ds interaction popup text: [ :obj |
		String streamContents: [ :aStream | | count |
			count := (yBlock cull: obj).
			aStream 
				nextPutAll: eventName;
				cr;
				nextPutAll: ' in category ';
				nextPutAll: obj categoryLabel asString;
				cr;
				nextPutAll: ' in ';
				nextPutAll: (count pluralize: dataName) ] ].
	ds points: points.
	ds barShape
		color: (Color green alpha: 0.3);
		width: 10.
	ds histogramWithBarTitle: #categoryLabel.
	ds y: yBlock.
	builder add: ds.

]

{ #category : #accessing }
GTACategoryBuilder >> collection [
	^ collection
]

{ #category : #accessing }
GTACategoryBuilder >> collection: anObject [
	collection := anObject
]

{ #category : #initialization }
GTACategoryBuilder >> initialize [
	super initialize.
	yBlock := [ :obj | obj size ].
	sortBlock := [ :obj | obj size ].
	sessionsPerInterest := [ :aCollection | self selectionEventsPerCategories ].
	self initializeBuilder.
	self initializeNumberOfComputersWithSelectionEvents
]

{ #category : #initialization }
GTACategoryBuilder >> initializeBuilder [
	| view |
	builder ifNotNil: [ view := builder view ].
	builder := RTGrapher new.
	view ifNotNil: [ builder view: view ].
]

{ #category : #initialization }
GTACategoryBuilder >> initializeNumberOfActOnAndCloseEvents [
	self initiliazeActOnAndCloseEvents.
	yBlock := [ :computers | computers numberOfSpecificEvents ].
	dataName := 'event'
]

{ #category : #initialization }
GTACategoryBuilder >> initializeNumberOfComputersWithActOnAndCloseEvents [
	self initiliazeActOnAndCloseEvents.
	yBlock := [ :computers | computers size ].
	dataName := 'computer'
]

{ #category : #initialization }
GTACategoryBuilder >> initializeNumberOfComputersWithSelectionEvents [
	self initiliazeSelectionEvents.
	yBlock := [ :computers | computers size ].
	dataName := 'computer'
]

{ #category : #initialization }
GTACategoryBuilder >> initializeNumberOfSelectionEvents [
	self initiliazeSelectionEvents.
	yBlock := [ :computers | computers numberOfSpecificEvents ].
	dataName := 'event'
]

{ #category : #initialization }
GTACategoryBuilder >> initializeNumberOfSessionsWithActOnAndCloseEvents [
	self initiliazeActOnAndCloseEvents.
	yBlock := [ :computers | computers numberOfSpecificSessions ].
	dataName := 'session'
]

{ #category : #initialization }
GTACategoryBuilder >> initializeNumberOfSessionsWithSelectionEvents [
	self initiliazeSelectionEvents.
	yBlock := [ :computers | computers numberOfSpecificSessions ].
	dataName := 'session'
]

{ #category : #initialization }
GTACategoryBuilder >> initiliazeActOnAndCloseEvents [
	eventSelectionBlock := [ :eachEvent | eachEvent isCloseSpotter ].
	eventName := 'Act-On or Close Event'.
]

{ #category : #initialization }
GTACategoryBuilder >> initiliazeSelectionEvents [
	eventSelectionBlock := [ :eachEvent | eachEvent isCategorySelection ].
	eventName := 'Selection Event'.
]

{ #category : #building }
GTACategoryBuilder >> rebuild [
	self view removeAllElements.
	self initializeBuilder.
	self build.
	self view signalUpdate.
]

{ #category : #enumerating }
GTACategoryBuilder >> selectionEventsPerCategories [
	| computers dictionary |
	dictionary := Dictionary new.
	computers := self collection selectComputersWithEvents: eventSelectionBlock.
	computers do: [ :eachComputer |
		eachComputer categoryLabels asSet do: [ :eachLabel |
				dictionary 
					at: eachLabel
					ifPresent: [ :aCollection | aCollection add: eachComputer ]
					ifAbsent: [ dictionary 
										at: eachLabel 
										put: (GTASomeComputers new
													add: eachComputer;
													categoryLabel: eachLabel;
													computers: self collection computers;
													yourself) ] ] ].
	computers := dictionary associations 
		collect: #value
		as: GTASomeComputers.
	computers do: [ :eachComputers | | block events sessions |
		block := [ :eachEvent | (eventSelectionBlock cull: eachEvent) and: [ eachEvent categoryLabel = eachComputers categoryLabel ] ].
		events := eachComputers flatCollectEvents: block.
		eachComputers numberOfSpecificEvents: events size.
		sessions := eachComputers selectSessionsWithEvents: block.
		eachComputers numberOfSpecificSessions: sessions size ].
	computers computers: self collection computers.
	^ computers
]

{ #category : #enumerating }
GTACategoryBuilder >> sessionsPerInterest [
	^ (sessionsPerInterest cull: self collection) sortedAs: [ :a :b | (sortBlock cull: a) > (sortBlock cull: b) ]
]

{ #category : #initialization }
GTACategoryBuilder >> sortIt [
	sortBlock := yBlock
]

{ #category : #accessing }
GTACategoryBuilder >> view [
	^ builder view
]
