Class {
	#name : #GTAMenuTimelineBuilder,
	#superclass : #Object,
	#instVars : [
		'timelineBuilder',
		'menuBuilder'
	],
	#category : #'GT-Spotter-EventRecorder-Analysis-Roassal-Timeline'
}

{ #category : #building }
GTAMenuTimelineBuilder >> build [
	self renderIn: timelineBuilder view.
]

{ #category : #'event handling' }
GTAMenuTimelineBuilder >> divingUsage [
	self numberOfOccurrences: #divesIn inform: 'No dives-in.'

]

{ #category : #initialization }
GTAMenuTimelineBuilder >> initialize [
	super initialize.
	menuBuilder := RTMenuBuilder new.
]

{ #category : #'event handling' }
GTAMenuTimelineBuilder >> keywordUsage [
	self numberOfOccurrences: #specialKeywords inform: 'No keywords.'

]

{ #category : #'event handling' }
GTAMenuTimelineBuilder >> numberOfOccurrences: aSymbol inform: aNoOccurrencesString [
	| elements keywords normalizer maxKeywords |
	elements := timelineBuilder elements.
	keywords := elements collect: [ :e | e -> (e model perform: aSymbol) size ].
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

{ #category : #'event handling' }
GTAMenuTimelineBuilder >> numberOfSessions [
	self numberOfOccurrences: #yourself inform: 'There is not any session.'

]

{ #category : #hooks }
GTAMenuTimelineBuilder >> renderIn: aView [
	menuBuilder view: aView.
	menuBuilder menu: 'Feature usage' submenu: 'Sessions' callback: [ self numberOfSessions ].
	menuBuilder menu: 'Feature usage' submenu: 'Keyword' callback: [ self keywordUsage ].
	menuBuilder menu: 'Feature usage' submenu: 'Diving' callback: [ self divingUsage ].
	
	menuBuilder menu: 'Data cleaning' submenu: 'Unknown items' callback: [ self unknownItems ].

	menuBuilder menu: 'Clean' callback: [ self unspeciedFeature ].

]

{ #category : #accessing }
GTAMenuTimelineBuilder >> timelineBuilder [
	^ timelineBuilder
]

{ #category : #accessing }
GTAMenuTimelineBuilder >> timelineBuilder: anObject [
	timelineBuilder := anObject
]

{ #category : #'event handling' }
GTAMenuTimelineBuilder >> unknownItems [
	self numberOfOccurrences: #unknownNames inform: 'No unknown names.'
]

{ #category : #'event handling' }
GTAMenuTimelineBuilder >> unspeciedFeature [
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
