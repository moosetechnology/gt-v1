Class {
	#name : #GTAComputer,
	#superclass : #GTASomeSessions,
	#traits : 'TGTSpotterUpdateEvents',
	#classTraits : 'TGTSpotterUpdateEvents classTrait',
	#category : #'GT-Spotter-EventRecorder-Analysis-Core'
}

{ #category : #api }
GTAComputer >> bookmarkIt [
	self bookmarks
		addComputer: self
		description: 'Added at ', DateAndTime now rounded asString;
		save
]

{ #category : #accessing }
GTAComputer >> bookmarks [
	^ self computers bookmarks
]

{ #category : #accessing }
GTAComputer >> computer [
	^ self
]

{ #category : #accessing }
GTAComputer >> computers [
	^ self optionAt: #computers
]

{ #category : #accessing }
GTAComputer >> computers: aCollection [ 
	^ self optionAt: #computers put: aCollection
]

{ #category : #enumerating }
GTAComputer >> differentSearchStrings [
	^ self searchStrings asSet
]

{ #category : #enumerating }
GTAComputer >> distinctSessions [
	"sessions that appear too close to each other might indicate a misstepped action.
	we consider distinct sessions all sessions that end at least 20 seconds before the next one"
	| distinctSessions |
	distinctSessions := OrderedCollection new.
	self overlappingPairsDo: [ :a :b | 
		((b start) - (a end) > 20 seconds) 
			ifTrue: [ distinctSessions add: a ] ].
	distinctSessions add: self last.
	^ distinctSessions
]

{ #category : #testing }
GTAComputer >> hasSessionsWithSpecialKeywords [
	^ self anySatisfy: #hasSpecialKeywords
]

{ #category : #testing }
GTAComputer >> hasSpecialKeywords [
	^ self anySatisfy: #hasSpecialKeywords
]

{ #category : #enumerating }
GTAComputer >> select: aBlock [
	| newCollection |
	newCollection := super select: aBlock.
	newCollection := newCollection as: GTASomeSessions.
	newCollection computer: self.
	^ newCollection
]

{ #category : #enumerating }
GTAComputer >> sessionsWithNumberOfInputsGreaterThen: anInteger [
	^ self select: [ :each | each numberOfContextChanged > anInteger ]
]

{ #category : #enumerating }
GTAComputer >> sessionsWithNumberOfInputsGreaterThenOne [
	^ self sessionsWithNumberOfInputsGreaterThen: 1
]

{ #category : #enumerating }
GTAComputer >> sessionsWithSpecialKeywords [
	^ self select: #hasSpecialKeywords
]

{ #category : #update }
GTAComputer >> updateEvents [
	^ self do: #updateEvents
]

{ #category : #enumerating }
GTAComputer >> userQueryOrSelectionHashes [
	^ self flatCollect: #userQueryOrSelectionHashes as: OrderedCollection
]
