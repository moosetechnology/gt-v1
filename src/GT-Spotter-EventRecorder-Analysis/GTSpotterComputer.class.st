Class {
	#name : #GTSpotterComputer,
	#superclass : #GTSpotterEventCollection,
	#traits : 'TGTSpotterDurationView + TGTSpotterSessionsTable + TGTSpotterCategoryView + TGTSpotterUpdateEvents',
	#classTraits : 'TGTSpotterDurationView classTrait + TGTSpotterSessionsTable classTrait + TGTSpotterCategoryView classTrait + TGTSpotterUpdateEvents classTrait',
	#category : #'GT-Spotter-EventRecorder-Analysis-Core'
}

{ #category : #helpers }
GTSpotterComputer >> avgNumberOfDivesIn [
	self ifEmpty: [ ^ 0 ].
	^ (self sum: #numberOfDivesIn) / self size
]

{ #category : #helpers }
GTSpotterComputer >> avgNumberOfDivesOut [
	self ifEmpty: [ ^ 0 ].
	^ (self sum: #numberOfDivesOut) / self size
]

{ #category : #enumerating }
GTSpotterComputer >> categoryLabels [
	^ self flatCollect: #categoryLabels as: OrderedCollection
]

{ #category : #accessing }
GTSpotterComputer >> computerUUID [
	self ifEmpty: [ ^ 0 ].
	^ self any computerUUID
]

{ #category : #enumerating }
GTSpotterComputer >> differentSearchStrings [
	^ self searchStrings asSet
]

{ #category : #'gt-inspector-extension' }
GTSpotterComputer >> durationView [
	| b ds |
	b := RTGrapher new.
	b extent: 500 @ 100.
	self ifEmpty: [ ^ b view ].
	ds := RTStackedDataSet new.
	ds interaction highlight.
	ds interaction popup text: [ :obj | obj sessionPopupText ].
	ds points: self.
	ds barShape 
			color: [ :obj | obj isWithPreview 
				ifTrue: [ Color green alpha: 0.3 ]
				ifFalse: [ Color blue alpha: 0.3 ] ]; 
			width: 10.
	ds y: [ :c | c duration asSeconds ].
	b add: ds.
	b axisX noTick; noLabel.
	b axisY.
	b build.
	^ b view.
	
]

{ #category : #'gt-inspector-extension' }
GTSpotterComputer >> gtInspectorDurationViewIn: composite [
	<gtInspectorPresentationOrder: 5>
	composite roassal2
		title: 'Duration';
		initializeView: [ self durationView ]
		
]

{ #category : #'gt-inspector-extension' }
GTSpotterComputer >> gtInspectorSessionsIn: composite [
	<gtInspectorPresentationOrder: -2>  
	^ (composite table)
		title: 'Sessions';
		display: [ :aComputer | aComputer ];
		column: 'Start' 
			evaluated: [ :each | String streamContents: [ :aStream | | start |
											start := each start.
											start = 0 
												ifTrue: [ aStream nextPutAll: 'unknown' ]
												ifFalse: [
													start asUTC printYMDOn: aStream.
													aStream nextPutAll: ', '.
													start asUTC printHMSOn: aStream ] ] ]
			width: 120;
		column: 'Duration' 
			evaluated: [ :each | GTObjectPrinter new asTruncatedTextFrom: each duration ] width: 67;
		column: 'Events' 
			evaluated: [ :each | GTObjectPrinter new asTruncatedTextFrom: each size ] width: 50;
		column: 'Preview' 
			evaluated: [ :each | GTObjectPrinter new asTruncatedTextFrom: each previewString ]
			width: 57;
		column: 'MissSteps' 
			evaluated: [ :each | each numberOfMissSteps ]
			width: 67;
		column: 'Inputs' 
			evaluated: [ :each | GTObjectPrinter new asTruncatedTextFrom: each numberOfContextChanged ]
			width: 47;
		column: 'Diff Inp.' 
			evaluated: [ :each | GTObjectPrinter new asTruncatedTextFrom: each numberOfDifferentSearchStrings ]
			width: 53;
		column: 'Fin. Searches' 
			evaluated: [ :each | GTObjectPrinter new asTruncatedTextFrom: each numberOfContextChanged ]
			width: 83;
		column: 'Selections' 
			evaluated: [ :each | GTObjectPrinter new asTruncatedTextFrom: each numberOfUserSelections ]
			width: 70;
		column: 'Dives In' 
			evaluated: [ :each | GTObjectPrinter new asTruncatedTextFrom: each numberOfDivesIn ]
			width: 53;
		column: 'Close' 
			evaluated: [ :each | each closeActionSymbol ]
			width: 63;
		column: 'Image Hashes' 
			evaluated: [ :each | GTObjectPrinter new asTruncatedTextFrom: each imageHashes size ]
			width: 70;
		beMultiple;
		send: [ :result | GTAMultipleSelectionSendCommand uniqueInstance selection: result in: self ];
		showOnly: 200
]

{ #category : #'gt-inspector-extension' }
GTSpotterComputer >> gtInspectorTimelineViewIn: composite [
	<gtInspectorPresentationOrder: 6>
	composite roassal2
		title: 'Timeline';
		initializeView: [ self timelineView ]
		
]

{ #category : #testing }
GTSpotterComputer >> hasSessionsWithSpecialKeywords [
	^ self anySatisfy: #hasSpecialKeywords
]

{ #category : #testing }
GTSpotterComputer >> hasSpecialKeywords [
	^ self anySatisfy: #hasSpecialKeywords
]

{ #category : #testing }
GTSpotterComputer >> isDeveloper [
	^ GTSpotterAnnouncements isDeveloper: self computerUUID
]

{ #category : #enumerating }
GTSpotterComputer >> missSteps [
	^ self flatCollect: #missSteps as: GTSpotterSession
]

{ #category : #helpers }
GTSpotterComputer >> numberOfContextChanged [
	self ifEmpty: [ ^ 0 ].
	^ self sum: #numberOfContextChanged
]

{ #category : #helpers }
GTSpotterComputer >> numberOfDifferentSearchStrings [
	^ self differentSearchStrings size
]

{ #category : #helpers }
GTSpotterComputer >> numberOfDivesIn [
	self ifEmpty: [ ^ 0 ].
	^ self sum: #numberOfDivesIn	
]

{ #category : #helpers }
GTSpotterComputer >> numberOfDivesOut [
	self ifEmpty: [ ^ 0 ].
	^ self sum: #numberOfDivesOut
]

{ #category : #helpers }
GTSpotterComputer >> numberOfEvents [
	self ifEmpty: [ ^ 0 ].
	^ self sum: #size
]

{ #category : #helpers }
GTSpotterComputer >> numberOfPreviews [
	^ self sessionsWithPreview size
]

{ #category : #enumerating }
GTSpotterComputer >> searchStrings [
	^ self flatCollect: #searchStrings as: Bag
]

{ #category : #enumerating }
GTSpotterComputer >> sessionsWithNumberOfInputsGreaterThen: anInteger [
	^ self select: [ :each | each numberOfContextChanged > anInteger ]
]

{ #category : #enumerating }
GTSpotterComputer >> sessionsWithNumberOfInputsGreaterThenOne [
	^ self sessionsWithNumberOfInputsGreaterThen: 1
]

{ #category : #enumerating }
GTSpotterComputer >> sessionsWithPreview [
	^ self select: #isWithPreview
]

{ #category : #enumerating }
GTSpotterComputer >> sessionsWithSpecialKeywords [
	^ self select: #hasSpecialKeywords
]

{ #category : #enumerating }
GTSpotterComputer >> spentTime [
	self ifEmpty: [ ^ 0 seconds ].
	^ self sum: #duration
]

{ #category : #accessing }
GTSpotterComputer >> start [
	self ifEmpty: [ ^ 0 ].
	^ self first start
]

{ #category : #accessing }
GTSpotterComputer >> stop [
	self ifEmpty: [ ^ 0 ].
	^ self last stop
]

{ #category : #'gt-inspector-extension' }
GTSpotterComputer >> timelineView [
	| composer builders |
	composer := RTComposer new.
	composer view @ RTZoomableView.
	builders := GTATimelineBuilders new.
	1 to: (self size min: 50) do: [ :index | | builder |
		builder := GTATimelineBuilder new.
		builder 
			view: composer view;
			configuration: GTADefaultTimelineConfiguration uniqueInstance;
			events: (self at: index);
			build.
		composer group: index.
		index > 1 ifTrue: [ composer move: index belowAlignFromLeft: index - 1 ].
		builders add: builder.
	 ].
	GTAMenuBuilder new timelineBuilder: builders; build.
	^ composer view.
]

{ #category : #update }
GTSpotterComputer >> updateEvents [
	^ self do: #updateEvents
]

{ #category : #accessing }
GTSpotterComputer >> userOrDeveloperString [
	^ self isDeveloper
			ifTrue: [ 'dev' ]
			ifFalse: [ 'user' ]
]
