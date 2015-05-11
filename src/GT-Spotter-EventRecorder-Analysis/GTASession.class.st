Class {
	#name : #GTASession,
	#superclass : #GTAEventCollection,
	#traits : 'TGTSpotterCategoryView',
	#classTraits : 'TGTSpotterCategoryView classTrait',
	#category : #'GT-Spotter-EventRecorder-Analysis-Core'
}

{ #category : #enumerating }
GTASession >> categoryLabels [
	^ self categorySelections collect: #categoryLabel as: OrderedCollection
]

{ #category : #enumerating }
GTASession >> categorySelections [
	^ self select: #isCategorySelection
]

{ #category : #accessing }
GTASession >> closeActionSymbol [
	self ifEmpty: [ ^ #empty ].
	^ self last closeActionSymbol
]

{ #category : #accessing }
GTASession >> computer [
	^ self optionAt: #computer
]

{ #category : #accessing }
GTASession >> computer: aGTSpotterComputer [
	^ self optionAt: #computer put: aGTSpotterComputer
]

{ #category : #accessing }
GTASession >> computerUUID [
	self ifEmpty: [ ^ 0 ].
	^ self any computerUUID
]

{ #category : #comparing }
GTASession >> deepestDiveIn [
	^ self max: #diveInLevel
]

{ #category : #accessing }
GTASession >> end [
	self ifEmpty: [ ^ 0 ].
	^ self last dateAndTimeWithFixedTimeZone
]

{ #category : #'gt-inspector-extension' }
GTASession >> gtInspectorEventsIn: composite [
	<gtInspectorPresentationOrder: -2>  
	^ (composite table)
		title: 'Events';
		display: [ :aSession | aSession ];
		column: 'Event' 
			evaluated: [ :each | each asEventAnalysisString ] width: 400;
		column: 'Time' 
			evaluated: [ :each | GTSpotterPrintDateAndTime yyyyMmDdAndHhMmSs: each dateAndTimeWithFixedTimeZone ]
			width: 120;
		withSmalltalkSearch;
		helpMessage: 'Given your INPUT, it executes: self select: [:each | INPUT ]';
		showOnly: 200
]

{ #category : #'gt-inspector-extension' }
GTASession >> gtInspectorStrangeEventsIn: composite [
	<gtInspectorPresentationOrder: 9>  
	^ (composite tree)
		title: 'Strange';
		display: [ :aSession | aSession select: #isStrange ];
		children: [ :eachChild |
			eachChild isString 
				ifTrue: [ #() ]
				ifFalse: [ eachChild strange ] ];
		format: [ :eachEvent | 
			eachEvent isString 
				ifTrue: [ eachEvent ]
				ifFalse: [ eachEvent asEventAnalysisString, 
								' with ', eachEvent strange size asString, ' strange observations.' ] ]
]

{ #category : #'gt-inspector-extension' }
GTASession >> gtInspectorTimelineView3In: composite [
	<gtInspectorPresentationOrder: 6>
	composite roassal2
		title: 'Timeline 3';
		initializeView: [ self timelineView3 ]
		
]

{ #category : #'gt-inspector-extension' }
GTASession >> gtInspectorTimelineViewIn: composite [
	<gtInspectorPresentationOrder: 5>
	composite roassal2
		title: 'Timeline';
		initializeView: [ self timelineView ]
		
]

{ #category : #'gt-inspector-extension' }
GTASession >> gtInspectorTreeEventsIn: composite [
	<gtInspectorPresentationOrder: -1>  
	^ (composite tree)
		title: 'Tree';
		display: [ :aSession | aSession roots ];
		children: [ :eachChild |
			eachChild children ];
		format: [ :eachEvent | eachEvent asEventAnalysisString ]
		
]

{ #category : #testing }
GTASession >> hasSpecialKeywords [
	^ self anySatisfy: [ :each | each isContextChanged and: [ each hasCurrentTextSpecials ] ]
]

{ #category : #accessing }
GTASession >> imageHashes [
	^ (self collect: #imageHash as: OrderedCollection) removeDuplicates
]

{ #category : #testing }
GTASession >> isWithPreview [
	^ (self contains: #isShowPreview) and: [ 
			(self contains: #isHidePreview) not ]
]

{ #category : #enumerating }
GTASession >> missSteps [
	| collection |
	collection := self select: #isMissStep.
	collection computer: self computer.
	^ collection
]

{ #category : #accessing }
GTASession >> previewString [
	^ self isWithPreview
		ifTrue: [ 'yes' ]
		ifFalse: [ 'no' ]
]

{ #category : #enumerating }
GTASession >> roots [
	^ self select: #isRootEvent
]

{ #category : #enumerating }
GTASession >> searchStrings [
	^ ((self select: #isContextChanged)
			flatCollect: #currentTextHashes as: Bag)
]

{ #category : #enumerating }
GTASession >> specialKeywords [
	^ self select: [ :each | each isContextChanged and: [ each hasCurrentTextSpecials ] ]
]

{ #category : #accessing }
GTASession >> start [
	self ifEmpty: [ ^ 0 ].
	^ self first dateAndTimeWithFixedTimeZone
]

{ #category : #'gt-inspector-extension' }
GTASession >> timelineView [
	| builder |
	builder := GTATimelineBuilder new.
	builder 
		configuration: GTADefaultTimelineConfiguration uniqueInstance;
		events: self;
		build.
	GTAMenuBuilder new timelineBuilder: builder; build.
	builder view canvas focusOnCenterScaled.
	^ builder view.
]

{ #category : #'gt-inspector-extension' }
GTASession >> timelineView3 [
	^ GTSpotterTimeline viewOn: self
]

{ #category : #update }
GTASession >> updateEvents [
	^ GTSpotterSessionAnalysis updateOn: self
]

{ #category : #enumerating }
GTASession >> userQueryOrSelectionHashes [
	^ self flatCollect: #userQueryOrSelectionHashes as: OrderedCollection 
]
