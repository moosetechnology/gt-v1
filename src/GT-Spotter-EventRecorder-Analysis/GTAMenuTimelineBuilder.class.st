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
		element trachelShape allVisibleColor: (normalizer rtValue: elementKeywords value) ].
	timelineBuilder view signalUpdate
]

{ #category : #hooks }
GTAMenuTimelineBuilder >> renderIn: aView [
	menuBuilder view: aView.
	menuBuilder menu: 'Feature usage' submenu: 'Keyword' callback: [ self keywordUsage ].
	menuBuilder menu: 'Feature usage' submenu: 'Diving' callback: [ self divingUsage ].
	
	menuBuilder menu: 'Data cleaning' submenu: 'Unknown items' callback: [ self unknownItems ].

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
