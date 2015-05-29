Class {
	#name : #GTASomeComputers,
	#superclass : #GTACollection,
	#category : #'GT-Spotter-EventRecorder-Analysis-Core'
}

{ #category : #enumerating }
GTASomeComputers >> categoryLabels [
	^ self flatCollect: #categoryLabels as: OrderedCollection
]

{ #category : #enumerating }
GTASomeComputers >> computerUUIDs [
	^ self collect: #computerUUID as: OrderedCollection
]

{ #category : #accessing }
GTASomeComputers >> computers [
	^ self optionAt: #computers
]

{ #category : #accessing }
GTASomeComputers >> computers: aCollection [ 
	^ self optionAt: #computers put: aCollection
]

{ #category : #enumerating }
GTASomeComputers >> computersAndOnlySessionsWithSpecialKeywords [
	^ self 
		select: [ :computer | computer hasSessionsWithSpecialKeywords ]
		thenCollect: [ :computer | 
			computer sessionsWithSpecialKeywords	]
]

{ #category : #enumerating }
GTASomeComputers >> divesIn [
	^ self flatCollect: #divesIn as: OrderedCollection
]

{ #category : #enumerating }
GTASomeComputers >> flatCollectEvents: aBlock [ 
	^ self flatCollect: [ :eachComputer | eachComputer flatCollectEvents: aBlock ] as: OrderedCollection
]

{ #category : #'gt-inspector-extension' }
GTASomeComputers >> gtInspectorComputersIn: composite [
	<gtInspectorPresentationOrder: -10>  
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
		send: [ :result | GTAMultipleSelectionSendCommand selection: result in: self as: GTASomeComputers ];
		showOnly: 100
]

{ #category : #'gt-inspector-extension' }
GTASomeComputers >> gtInspectorTimelineViewIn: composite [
	<gtInspectorPresentationOrder: -8>
	composite roassal2
		title: 'Timeline';
		initializeView: [ self timelineView ]
		
]

{ #category : #enumerating }
GTASomeComputers >> missSteps [
	^ self flatCollect: #missSteps as: GTASession
]

{ #category : #enumerating }
GTASomeComputers >> numberOfContextChanged [
	self ifEmpty: [ ^ 0 ].
	^ self sum: #numberOfContextChanged 
]

{ #category : #helpers }
GTASomeComputers >> numberOfEvents [
	^ self sum: [ :each | each numberOfEvents ]
]

{ #category : #helpers }
GTASomeComputers >> numberOfMissSteps [
	^ self missSteps size
]

{ #category : #helpers }
GTASomeComputers >> numberOfSessions [
	^ self sum: [ :each | each size ]
]

{ #category : #enumerating }
GTASomeComputers >> sessions [
	^ self flatCollect: #yourself as: GTASessions
]

{ #category : #enumerating }
GTASomeComputers >> sessionsWithNumberOfInputsGreaterThen: anInteger [
	^ self collect: [ :each | each copy sessionsWithNumberOfInputsGreaterThen: anInteger ]
]

{ #category : #enumerating }
GTASomeComputers >> sessionsWithNumberOfInputsGreaterThenOne [
	^ self sessionsWithNumberOfInputsGreaterThen: 1
]

{ #category : #'as yet unclassified' }
GTASomeComputers >> sortByDevelopersAndDuration [
	self sort: [ :a :b | | duration |
		duration := a duration > b duration.
		(a isDeveloper and: [ duration ]) or: [ 
			(b isDeveloper not and: [ duration ]) or: [ 
				a isDeveloper and: [ b isDeveloper not and: [ duration not ] ] ] ] ]
]

{ #category : #enumerating }
GTASomeComputers >> specialKeywords [
	^ self flatCollect: #specialKeywords as: OrderedCollection
]

{ #category : #'gt-inspector-extension' }
GTASomeComputers >> timelineView [
	| builder minTime dataSetBuilder |
	builder := RTTimeline new.
	minTime := self start asUnixTime.
	dataSetBuilder := GTARoughDataSetBuilder new
		gap: self duration / 48;
		setSessionComparator;
		yourself.
	self reverseWithIndexDo: [ :eachComputer :index | | set objects |
		dataSetBuilder 
			objects: eachComputer; 
			newGroupBlock: [ GTASomeSessions new computer: eachComputer; yourself ];
			build.
		objects := dataSetBuilder groups collect: [ :eachGroup |
			eachGroup size = 1 ifTrue: [ eachGroup any ] ifFalse: [ eachGroup ] ].
		set := RTTimelineSet new.
		set
			lineIdentifier: index;
			objects: objects;
			start: [ :eachSession | eachSession start asUnixTime - minTime ];
			end: [ :eachSession | eachSession end asUnixTime - minTime ].
		set interaction popupText: #humanReadablePrintString.
		set shape color: (RTMultiLinearColorForIdentity new 
							command: [ :eachSession | objects indexOf: eachSession ]; 
							objects: (1 to: objects size);
							yourself).
		builder add: set.
	 ].
	builder axisX 
		numberOfLabels: 5;
		labelRotation: 0;
		labelFontHeight: 8;
		labelConversion: [ :unixTime | 
			GTADateAndTimeStringBuilder new
				dateAndTime: (DateAndTime fromUnixTime: unixTime + minTime);
				duration: self duration;
				numberOfLabels: 5;
				humanReadablePrintString ].
	builder timelineLabelBuilder shape fontSize: 8.
	builder 
		timelineLabel: [ :lineIdentifier | String streamContents: [ :aStream |
				aStream 
					nextPutAll: (self at: lineIdentifier) userOrDeveloperString;
					space;
					print: lineIdentifier ] ];
		extent: 400 @ ((self size * 10) max: 200).
	builder build.
	GTAMenuTimelineBuilder new timelineBuilder: builder; build.
	^ builder
]

{ #category : #enumerating }
GTASomeComputers >> unknownNames [
	^ self flatCollect: #unknownNames as: OrderedCollection
]

{ #category : #update }
GTASomeComputers >> updateEvents [
	^ self do: #updateEvents
]
