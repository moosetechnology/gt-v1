Class {
	#name : #GTAComputers,
	#superclass : #GTACollection,
	#traits : 'TGTSpotterCategoryView + TGTSpotterUpdateEvents',
	#classTraits : 'TGTSpotterCategoryView classTrait + TGTSpotterUpdateEvents classTrait',
	#category : #'GT-Spotter-EventRecorder-Analysis-Core'
}

{ #category : #enumerating }
GTAComputers >> categoryLabels [
	^ self flatCollect: #categoryLabels as: OrderedCollection
]

{ #category : #enumerating }
GTAComputers >> computerUUIDs [
	^ self collect: #computerUUID as: OrderedCollection
]

{ #category : #enumerating }
GTAComputers >> computersAndOnlySessionsWithSpecialKeywords [
	^ self 
		select: [ :computer | computer hasSessionsWithSpecialKeywords ]
		thenCollect: [ :computer | 
			computer sessionsWithSpecialKeywords	]
]

{ #category : #enumerating }
GTAComputers >> flatCollectEvents: aBlock [ 
	^ self flatCollect: [ :eachComputer | eachComputer flatCollectEvents: aBlock ] as: OrderedCollection
]

{ #category : #'gt-inspector-extension' }
GTAComputers >> gtInspectorComputersIn: composite [
	<gtInspectorPresentationOrder: -2>  
	^ (composite table)
		title: 'Computers';
		display: [ :aComputer | aComputer ];
		column: 'Since' 
			evaluated: [ :each | String streamContents: [ :aStream | 
											each start = 0 
												ifTrue: [ aStream nextPutAll: 'unknown' ]
												ifFalse: [ each start asUTC printYMDOn: aStream ] ] ]
			width: 67;
		column: 'Days' 
			evaluated: [ :each | GTObjectPrinter new asTruncatedTextFrom: each duration asDuration asDays rounded ] 
			width: 40;
		column: 'Spent' 
			evaluated: [ :each | each spentTime ] 
			width: 63;
		column: 'User' 
			evaluated: [ :each | each userOrDeveloperString ] 
			width: 50;
		column: 'Sessions' 
			evaluated: [ :each | GTObjectPrinter new asTruncatedTextFrom: each size ] 
			width: 60;
		column: 'Events' 
			evaluated: [ :each | GTObjectPrinter new asTruncatedTextFrom: each numberOfEvents ] 
			width: 50;
		column: 'Previews' 
			evaluated: [ :each | GTObjectPrinter new asTruncatedTextFrom: each numberOfPreviews ] 
			width: 60;
		column: 'Inputs' 
			evaluated: [ :each | GTObjectPrinter new asTruncatedTextFrom: each numberOfContextChanged ]
			width: 47;
		column: 'Diff Inp.' 
			evaluated: [ :each | GTObjectPrinter new asTruncatedTextFrom: each numberOfDifferentSearchStrings ]
			width: 53;
		column: 'Dives In' 
			evaluated: [ :each | GTObjectPrinter new asTruncatedTextFrom: each numberOfDivesIn ]
			width: 53;
		column: 'Dives Out' 
			evaluated: [ :each | GTObjectPrinter new asTruncatedTextFrom: each numberOfDivesOut ]
			width: 63;
		column: 'Avg. D-In' 
			evaluated: [ :each | (each avgNumberOfDivesIn printShowingDecimalPlaces: 2)]
			width: 60;
		column: 'Avg. D-Out' 
			evaluated: [ :each | (each avgNumberOfDivesOut printShowingDecimalPlaces: 2) ]
			width: 67;
		column: 'MissSteps' 
			evaluated: [ :each | each numberOfMissSteps ]
			width: 60;
		beMultiple;
		send: [ :result | GTAMultipleSelectionSendCommand selection: result in: self ];
		showOnly: 50
]

{ #category : #'gt-inspector-extension' }
GTAComputers >> gtInspectorTimelineView2In: composite [
	<gtInspectorPresentationOrder: 6>
	composite roassal2
		title: 'Timeline 2';
		initializeView: [ self timelineView2 ]
		
]

{ #category : #'gt-inspector-extension' }
GTAComputers >> gtInspectorTimelineViewIn: composite [
	<gtInspectorPresentationOrder: 6>
	composite roassal2
		title: 'Timeline';
		initializeView: [ self timelineView ]
		
]

{ #category : #enumerating }
GTAComputers >> missSteps [
	^ self flatCollect: #missSteps as: GTASession
]

{ #category : #enumerating }
GTAComputers >> numberOfContextChanged [
	self ifEmpty: [ ^ 0 ].
	^ self sum: #numberOfContextChanged 
]

{ #category : #helpers }
GTAComputers >> numberOfEvents [
	^ self sum: [ :each | each numberOfEvents ]
]

{ #category : #helpers }
GTAComputers >> numberOfMissSteps [
	^ self missSteps size
]

{ #category : #helpers }
GTAComputers >> numberOfSessions [
	^ self sum: [ :each | each size ]
]

{ #category : #enumerating }
GTAComputers >> sessions [
	^ self flatCollect: #yourself as: GTASessions
]

{ #category : #enumerating }
GTAComputers >> sessionsWithNumberOfInputsGreaterThen: anInteger [
	^ self collect: [ :each | each copy sessionsWithNumberOfInputsGreaterThen: anInteger ]
]

{ #category : #enumerating }
GTAComputers >> sessionsWithNumberOfInputsGreaterThenOne [
	^ self sessionsWithNumberOfInputsGreaterThen: 1
]

{ #category : #enumerating }
GTAComputers >> specialKeywords [
	^ self flatCollect: #specialKeywords as: OrderedCollection
]

{ #category : #'gt-inspector-extension' }
GTAComputers >> timelineView [
	| builder minTime |
	builder := RTTimeLine new.
	minTime := self start asUnixTime.
	self reverseWithIndexDo: [ :eachComputer :index | 
		eachComputer do: [ :eachSession | | entry |
			entry := RTTimeLineEntry new.
			entry identifier: index.
			entry start: eachSession start asUnixTime - minTime.
			entry end: eachSession end asUnixTime - minTime.
			builder addEntry: entry.
		].
	 ].
	builder axisX 
		numberOfLabels: 5;
		labelRotation: -45;
		labelConversion: [ :unixTime | (DateAndTime fromUnixTime: unixTime + minTime) asDate ].
	builder axisY noLabel.
	builder shape color: (RTMultiLinearColorForIdentity new 
							command: #identifier; 
							objects: (1 to: self size);
							yourself).
	^ builder 
]

{ #category : #'gt-inspector-extension' }
GTAComputers >> timelineView2 [
	| builder minTime dataSetBuilder |
	builder := RTTimeLine new.
	minTime := self start asUnixTime.
	dataSetBuilder := GTARoughDataSetBuilder new
		gap: self duration / 48;
		setSessionComparator;
		yourself.
	self reverseWithIndexDo: [ :eachComputer :index | 
		dataSetBuilder objects: eachComputer; build.
		dataSetBuilder groups do: [ :eachGroup | | entry |
			entry := GTATimeLineEntry new.
			entry 
				identifier: index;
				computer: eachComputer;
				group: eachGroup;
				start: eachGroup start asUnixTime - minTime;
				end: eachGroup end asUnixTime - minTime.
			builder addEntry: entry.
		].
	 ].
	builder axisX 
		numberOfLabels: 5;
		labelRotation: -45;
		labelConversion: [ :unixTime | (DateAndTime fromUnixTime: unixTime + minTime) asDate ].
	builder axisY noLabel.
	builder interaction popup text: [ :group | 
		String streamContents: [ :aStream |
			aStream print: group size; nextPutAll: ' events' ] ].
	builder shape color: (RTMultiLinearColorForIdentity new 
							command: #identifier; 
							objects: (1 to: self size);
							yourself).
	^ builder 
]

{ #category : #update }
GTAComputers >> updateEvents [
	^ self do: #updateEvents
]
