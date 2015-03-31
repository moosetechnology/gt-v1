Class {
	#name : #GTSpotterComputers,
	#superclass : #OrderedCollection,
	#traits : 'TGTSpotterCategoryView',
	#classTraits : 'TGTSpotterCategoryView classTrait',
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

{ #category : #'gt-inspector-extension' }
GTSpotterComputers >> gtInspectorComputersIn: composite [
	<gtInspectorPresentationOrder: -2>  
	^ (composite table)
		title: 'Computers';
		display: [ :aComputer | aComputer ];
		column: 'Start' 
			evaluated: [ :each | String streamContents: [ :aStream | 
											each start = 0 
												ifTrue: [ aStream nextPutAll: 'unknown' ]
												ifFalse: [ each start asUTC printYMDOn: aStream ] ] ]
			width: 67;
		column: 'Duration' 
			evaluated: [ :each | GTObjectPrinter new asTruncatedTextFrom: each duration ] 
			width: 67;
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
			width: 60;
		showOnly: 50
]

{ #category : #enumerating }
GTSpotterComputers >> numberOfContextChanged [
	self ifEmpty: [ ^ 0 ].
	^ self sum: #numberOfContextChanged 
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

{ #category : #update }
GTSpotterComputers >> updateEvents [
	^ self do: #updateEvents
]
