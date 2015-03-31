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

{ #category : #'gt-inspector-extension' }
GTSpotterSession >> gtInspectorEventsIn: composite [
	<gtInspectorPresentationOrder: -2>  
	^ (composite table)
		title: 'Events';
		display: [ :aSession | aSession ];
		column: 'Event' 
			evaluated: [ :each | each asEventAnalysisString ] width: 300;
		column: 'Strange' 
			evaluated: [ :each | each isStrange ] width: 53;
		column: 'Image Hash' 
			evaluated: [ :each | GTObjectPrinter new asTruncatedTextFrom: each imageHash ] width: 75;
		column: 'Time' 
			evaluated: [ :each | String streamContents: [ :aStream | | start |
											start := each timestamp.
											start = 0 
												ifTrue: [ aStream nextPutAll: 'unknown' ]
												ifFalse: [
													start asUTC printYMDOn: aStream.
													aStream nextPutAll: ', '.
													start asUTC printHMSOn: aStream ] ] ]
			width: 120;
		column: 'Session Creation Time' 
			evaluated: [ :each | GTObjectPrinter new asTruncatedTextFrom: each sessionCreationTime ] width: 155;
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

{ #category : #update }
GTSpotterSession >> updateEvents [
	^ GTSpotterSessionAnalysis executeOn: self
]
