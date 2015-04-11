Class {
	#name : #GTSpotterSession,
	#superclass : #GTSpotterEventCollection,
	#traits : 'TGTSpotterCategoryView',
	#classTraits : 'TGTSpotterCategoryView classTrait',
	#category : #'GT-Spotter-EventRecorder-Analysis-Core'
}

{ #category : #enumerating }
GTSpotterSession >> categoryLabels [
	^ self categorySelections collect: #categoryLabel as: OrderedCollection
]

{ #category : #enumerating }
GTSpotterSession >> categorySelections [
	^ self select: #isCategorySelection
]

{ #category : #accessing }
GTSpotterSession >> closeActionSymbol [
	self ifEmpty: [ ^ #empty ].
	^ self last closeActionSymbol
]

{ #category : #accessing }
GTSpotterSession >> computerUUID [
	self ifEmpty: [ ^ 0 ].
	^ self any computerUUID
]

{ #category : #comparing }
GTSpotterSession >> deepestDiveIn [
	^ self max: #diveInLevel
]

{ #category : #'gt-inspector-extension' }
GTSpotterSession >> gtInspectorEventsIn: composite [
	<gtInspectorPresentationOrder: -2>  
	^ (composite table)
		title: 'Events';
		display: [ :aSession | aSession ];
		column: 'Event' 
			evaluated: [ :each | each asEventAnalysisString ] width: 400;
		column: 'Time' 
			evaluated: [ :each | GTSpotterPrintDateAndTime yyyyMmDdAndHhMmSs: each timestampWithFixedTimeZone ]
			width: 120;
		withSmalltalkSearch;
		helpMessage: 'Given your INPUT, it executes: self select: [:each | INPUT ]';
		showOnly: 200
]

{ #category : #'gt-inspector-extension' }
GTSpotterSession >> gtInspectorStrangeEventsIn: composite [
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
GTSpotterSession >> gtInspectorTimelineView2In: composite [
	<gtInspectorPresentationOrder: 6>
	composite roassal2
		title: 'Timeline 2';
		initializeView: [ self timelineView2 ]
		
]

{ #category : #'gt-inspector-extension' }
GTSpotterSession >> gtInspectorTimelineViewIn: composite [
	<gtInspectorPresentationOrder: 5>
	composite roassal2
		title: 'Timeline';
		initializeView: [ self timelineView ]
		
]

{ #category : #'gt-inspector-extension' }
GTSpotterSession >> gtInspectorTreeEventsIn: composite [
	<gtInspectorPresentationOrder: -1>  
	^ (composite tree)
		title: 'Tree';
		display: [ :aSession | aSession roots ];
		children: [ :eachChild |
			eachChild children ];
		format: [ :eachEvent | eachEvent asEventAnalysisString ]
		
]

{ #category : #accessing }
GTSpotterSession >> imageHashes [
	^ (self collect: #imageHash as: OrderedCollection) removeDuplicates
]

{ #category : #testing }
GTSpotterSession >> isWithPreview [
	^ (self contains: #isShowPreview) and: [ 
			(self contains: #isHidePreview) not ]
]

{ #category : #enumerating }
GTSpotterSession >> missSteps [
	^ self select: #isMissStep 
]

{ #category : #accessing }
GTSpotterSession >> previewString [
	^ self isWithPreview
		ifTrue: [ 'yes' ]
		ifFalse: [ 'no' ]
]

{ #category : #enumerating }
GTSpotterSession >> roots [
	^ self select: #isRootEvent
]

{ #category : #enumerating }
GTSpotterSession >> searchStrings [
	^ ((self select: #isContextChanged)
			flatCollect: #currentTextHashes as: Bag)
]

{ #category : #accessing }
GTSpotterSession >> start [
	self ifEmpty: [ ^ 0 ].
	^ self first timestampWithFixedTimeZone
]

{ #category : #accessing }
GTSpotterSession >> stop [
	self ifEmpty: [ ^ 0 ].
	^ self last timestampWithFixedTimeZone
]

{ #category : #'gt-inspector-extension' }
GTSpotterSession >> timelineView [
	^ GTATimelineBuilder viewOn: self
]

{ #category : #'gt-inspector-extension' }
GTSpotterSession >> timelineView2 [
	^ GTSpotterTimeline viewOn: self
]

{ #category : #update }
GTSpotterSession >> updateEvents [
	^ GTSpotterSessionAnalysis updateOn: self
]
