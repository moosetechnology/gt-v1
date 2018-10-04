Class {
	#name : #GTAMenuTimelineBuilder,
	#superclass : #Object,
	#instVars : [
		'timelineBuilder',
		'menuBuilder',
		'currentCategoryLabel',
		'computers',
		'categoryLabels',
		'categoryMarker'
	],
	#category : #'GT-Spotter-EventRecorder-Analysis-Roassal-Timeline'
}

{ #category : #building }
GTAMenuTimelineBuilder >> build [
	self renderIn: timelineBuilder view.
]

{ #category : #accessing }
GTAMenuTimelineBuilder >> categoryLabels [
	^ categoryLabels ifNil: [ categoryLabels := self computers categoryLabels asSet asSortedCollection ]
]

{ #category : #accessing }
GTAMenuTimelineBuilder >> categoryMarker [
	^ categoryMarker
]

{ #category : #'event handling' }
GTAMenuTimelineBuilder >> clean [
	| elements normalizer  |
	elements := timelineBuilder elements.
	normalizer := RTMultiLinearColorForIdentity new 
							objects: elements;
							yourself.
	elements do: [ :element |
		element trachelShape 
			color: (normalizer rtValue: element);
			strokePaint: Color transparent ].
	timelineBuilder view signalUpdate
]

{ #category : #accessing }
GTAMenuTimelineBuilder >> computers [
	^ computers
]

{ #category : #accessing }
GTAMenuTimelineBuilder >> computers: aCollection [ 
	computers := aCollection
]

{ #category : #accessing }
GTAMenuTimelineBuilder >> currentCategoryLabel [
	^ currentCategoryLabel ifNil: [ currentCategoryLabel := self categoryLabels anyOne ]
]

{ #category : #'event handling - intensity' }
GTAMenuTimelineBuilder >> divingUsage [
	self numberOfOccurrences: #divesIn inform: 'No dives-in.'

]

{ #category : #hooks }
GTAMenuTimelineBuilder >> generateCategoryMenu [
	| categoryMenuName |
	categoryMenuName := 'Categories'.
	self categoryLabels withIndexDo: [ :eachCategory :index | 
		index \\ 25 = 0 ifTrue: [ categoryMenuName := 'Categories ', (index // 25 + 1) asString ].
		menuBuilder 
			menu: categoryMenuName 
			submenu: eachCategory 
			callback: [ self markCategory: eachCategory ] ].
]

{ #category : #'event handling - usage' }
GTAMenuTimelineBuilder >> highlightActOnAndCloseCategories [
	self highlightSessionsWithEvents: [ :eachEvent | 
			eachEvent isCloseSpotter and: [ eachEvent selectedCategoryLabel = self currentCategoryLabel ] ].
	categoryMarker := [ self highlightActOnAndCloseCategories ].
]

{ #category : #'event handling - usage' }
GTAMenuTimelineBuilder >> highlightCategoryFilters [
	self highlightSessionsWithEvents: [ :eachEvent | eachEvent isContextChanged and: [ eachEvent hasCurrentTextSpecials ] ]
]

{ #category : #'event handling - usage' }
GTAMenuTimelineBuilder >> highlightComposedQueries [
	self highlightSessionsWithEvents: [ :eachEvent | 
		(eachEvent isSearchFinished and: [ (eachEvent currentQuerySpecials reject: [ :b | b = true ]) size > 1 ]) 
			and: [ eachEvent notEmptyCategories isEmpty ] ]
]

{ #category : #'event handling - usage' }
GTAMenuTimelineBuilder >> highlightCustomizedSpotterExtenstions [
	self highlightSessionsWithEvents: [ :eachEvent | 
		eachEvent isCategorySelection and: [ eachEvent isCustomizedSpotterExtension ] ]
]

{ #category : #'event handling - usage' }
GTAMenuTimelineBuilder >> highlightDivesIn [
	self highlightSessionsWithEvents: [ :eachEvent | eachEvent isDiveIn ]
]

{ #category : #'event handling - usage' }
GTAMenuTimelineBuilder >> highlightDivesInCategory [
	self highlightSessionsWithEvents: [ :eachEvent | eachEvent isCategoryDiveIn ]
]

{ #category : #'event handling - usage' }
GTAMenuTimelineBuilder >> highlightDivesInElement [
	self highlightSessionsWithEvents: [ :eachEvent | eachEvent isElementDiveIn ]
]

{ #category : #'event handling - usage' }
GTAMenuTimelineBuilder >> highlightPharo5Users [
	self highlightSessionsWithEvents: [ :eachEvent | 
		eachEvent latestUpdate >= 50000 ]
]

{ #category : #'event handling - usage' }
GTAMenuTimelineBuilder >> highlightSelectionCategories [
	self highlightSessionsWithEvents: [ :eachEvent | 
			eachEvent isUserSelection and: [ eachEvent selectedCategoryLabel = self currentCategoryLabel ] ].
	categoryMarker := [ self highlightSelectionCategories ].
]

{ #category : #'event handling - usage' }
GTAMenuTimelineBuilder >> highlightSessionsWithEvents: aBlock [
	timelineBuilder elements do: [ :eachElement | | color |
		(eachElement model anyEventSatisfy: aBlock)
			ifTrue: [ color := Color red ]
			ifFalse: [ color := Color white ].
		eachElement trachelShape 
			color: color;
			strokePaint: (Color black alpha: 0.4) ].
	timelineBuilder view signalUpdate
]

{ #category : #'event handling - usage' }
GTAMenuTimelineBuilder >> highlightShowPreview [
	self highlightSessionsWithEvents: [ :eachEvent | eachEvent isShowPreview ]
]

{ #category : #initialization }
GTAMenuTimelineBuilder >> initialize [
	super initialize.
	menuBuilder := RTMenuBuilder new.
	self initializeHighlightActOnAndCloseMarker.
	
]

{ #category : #initialization }
GTAMenuTimelineBuilder >> initializeHighlightActOnAndCloseMarker [
	categoryMarker := [ self highlightActOnAndCloseCategories ]
]

{ #category : #'event handling - intensity' }
GTAMenuTimelineBuilder >> intensityOfActOnAndCloseCategories [
	self 
		numberOfOccurrences: [ :eachSessionOrSomeSessions |
			eachSessionOrSomeSessions flatCollectEvents: [ :eachEvent | 
							eachEvent isCloseSpotter and: [ 
								eachEvent selectedCategoryLabel = self currentCategoryLabel ] ] ]
		inform: 'There are not such category labels.'.
	categoryMarker := [ self intensityOfActOnAndCloseCategories ].
]

{ #category : #'event handling - intensity' }
GTAMenuTimelineBuilder >> intensityOfSelectionCategories [
	self 
		numberOfOccurrences: [ :eachSessionOrSomeSessions |
			eachSessionOrSomeSessions flatCollectEvents: [ :eachEvent | 
							eachEvent isUserSelection and: [ 
								eachEvent selectedCategoryLabel = self currentCategoryLabel ] ] ]
		inform: 'There are not such category labels.'.
	categoryMarker := [ self intensityOfSelectionCategories ].

]

{ #category : #'event handling - intensity' }
GTAMenuTimelineBuilder >> keywordUsage [
	self numberOfOccurrences: #specialKeywords inform: 'No keywords.'

]

{ #category : #'event handling' }
GTAMenuTimelineBuilder >> markCategory: aString [ 
	currentCategoryLabel := aString.
	self categoryMarker value.
]

{ #category : #'event handling - intensity' }
GTAMenuTimelineBuilder >> numberOfOccurrences: aSymbol inform: aNoOccurrencesString [
	| elements keywords normalizer maxKeywords |
	elements := timelineBuilder elements.
	keywords := elements collect: [ :e | e -> (aSymbol cull: e model) size ].
	maxKeywords := keywords max: [ :assoc | assoc value ].
	maxKeywords = 0 ifTrue: [ 
		self inform: aNoOccurrencesString.
		^ self ].
	normalizer := RTGrayLinearColor new.
	normalizer command: #yourself; scope: (0 to: maxKeywords).
	elements do: [ :element | | elementKeywords |
		elementKeywords := keywords detect: [ :assoc | assoc key == element ].
		element trachelShape 
			color: (normalizer rtValue: elementKeywords value);
			strokePaint: (Color black alpha: 0.4) ].
	timelineBuilder view signalUpdate
]

{ #category : #'event handling - intensity' }
GTAMenuTimelineBuilder >> numberOfSessions [
	self numberOfOccurrences: #sessions inform: 'There is not any session.'

]

{ #category : #hooks }
GTAMenuTimelineBuilder >> renderIn: aView [
	menuBuilder view: aView.
	menuBuilder menu: 'Feature Intensity' submenu: 'Category Filter' callback: [ self keywordUsage ].
	menuBuilder menu: 'Feature Intensity' submenu: 'Dive-In' callback: [ self divingUsage ].
	menuBuilder menu: 'Feature Intensity' submenu: 'Selection Categories' callback: [ self intensityOfSelectionCategories ].
	menuBuilder menu: 'Feature Intensity' submenu: 'Act-On and Close Categories' callback: [ self intensityOfActOnAndCloseCategories ].
	menuBuilder menu: 'Feature Intensity' submenu: 'Number of Sessions' callback: [ self numberOfSessions ].
	menuBuilder menu: 'Feature Intensity' submenu: 'Unknown items' callback: [ self unknownItems ].

	menuBuilder menu: 'Feature Usage' submenu: 'Category Filter' callback: [ self highlightCategoryFilters ].
	menuBuilder menu: 'Feature Usage' submenu: 'Dive-In All' callback: [ self highlightDivesIn ].
	menuBuilder menu: 'Feature Usage' submenu: 'Dive-In Element' callback: [ self highlightDivesInElement ].
	menuBuilder menu: 'Feature Usage' submenu: 'Dive-In Category' callback: [ self highlightDivesInCategory ].
	menuBuilder menu: 'Feature Usage' submenu: 'Show Preview' callback: [ self highlightShowPreview ].
	menuBuilder menu: 'Feature Usage' submenu: 'Selection Categories' callback: [ self highlightSelectionCategories ].
	menuBuilder menu: 'Feature Usage' submenu: 'Act-On and Close Categories' callback: [ self highlightActOnAndCloseCategories ].
	menuBuilder menu: 'Feature Usage' submenu: 'Composed Queries' callback: [ self highlightComposedQueries ].
	menuBuilder menu: 'Feature Usage' submenu: 'Pharo 5 Images' callback: [ self highlightPharo5Users ].
	menuBuilder menu: 'Feature Usage' submenu: 'Customized Spotter Extensions' callback: [ self highlightCustomizedSpotterExtenstions ].

	self generateCategoryMenu.
	menuBuilder menu: 'Clean' callback: [ self clean ].

]

{ #category : #accessing }
GTAMenuTimelineBuilder >> timelineBuilder [
	^ timelineBuilder
]

{ #category : #accessing }
GTAMenuTimelineBuilder >> timelineBuilder: anObject [
	timelineBuilder := anObject
]

{ #category : #'event handling - intensity' }
GTAMenuTimelineBuilder >> unknownItems [
	self numberOfOccurrences: #unknownNames inform: 'No unknown names.'
]
