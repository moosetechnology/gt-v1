Class {
	#name : #GTSpotterComputers,
	#superclass : #OrderedCollection,
	#traits : 'TGTSpotterCategoryView + TGTSpotterUpdateEvents',
	#classTraits : 'TGTSpotterCategoryView classTrait + TGTSpotterUpdateEvents classTrait',
	#category : #'GT-Spotter-EventRecorder-Analysis-Core'
}

{ #category : #enumerating }
GTSpotterComputers >> categoryLabels [
	^ self flatCollect: #categoryLabels as: OrderedCollection
]

{ #category : #enumerating }
GTSpotterComputers >> computerUUIDs [
	^ self collect: #computerUUID as: OrderedCollection
]

{ #category : #enumerating }
GTSpotterComputers >> computersAndOnlySessionsWithSpecialKeywords [
	^ self 
		select: [ :computer | computer hasSessionsWithSpecialKeywords ]
		thenCollect: [ :computer | 
			computer sessionsWithSpecialKeywords	]
]

{ #category : #enumerating }
GTSpotterComputers >> flatCollectEvents: aBlock [ 
	^ self flatCollect: [ :eachComputer | eachComputer flatCollectEvents: aBlock ] as: OrderedCollection
]

{ #category : #'gt-inspector-extension' }
GTSpotterComputers >> gtInspectorComputersIn: composite [
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
		showOnly: 50
]

{ #category : #enumerating }
GTSpotterComputers >> missSteps [
	^ self flatCollect: #missSteps as: GTSpotterSession
]

{ #category : #enumerating }
GTSpotterComputers >> numberOfContextChanged [
	self ifEmpty: [ ^ 0 ].
	^ self sum: #numberOfContextChanged 
]

{ #category : #helpers }
GTSpotterComputers >> numberOfEvents [
	^ self sum: [ :each | each numberOfEvents ]
]

{ #category : #helpers }
GTSpotterComputers >> numberOfMissSteps [
	^ self missSteps size
]

{ #category : #helpers }
GTSpotterComputers >> numberOfSessions [
	^ self sum: [ :each | each size ]
]

{ #category : #enumerating }
GTSpotterComputers >> sessions [
	^ self flatCollect: #yourself as: GTSpotterSessions
]

{ #category : #enumerating }
GTSpotterComputers >> sessionsWithNumberOfInputsGreaterThen: anInteger [
	^ self collect: [ :each | each copy sessionsWithNumberOfInputsGreaterThen: anInteger ]
]

{ #category : #enumerating }
GTSpotterComputers >> sessionsWithNumberOfInputsGreaterThenOne [
	^ self sessionsWithNumberOfInputsGreaterThen: 1
]

{ #category : #enumerating }
GTSpotterComputers >> specialKeywords [
	^ self flatCollect: #specialKeywords as: OrderedCollection
]

{ #category : #update }
GTSpotterComputers >> updateEvents [
	^ self do: #updateEvents
]
