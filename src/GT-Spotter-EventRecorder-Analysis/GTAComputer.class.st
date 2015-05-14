Class {
	#name : #GTAComputer,
	#superclass : #GTASomeSessions,
	#category : #'GT-Spotter-EventRecorder-Analysis-Core'
}

{ #category : #helpers }
GTAComputer >> avgNumberOfDivesIn [
	self ifEmpty: [ ^ 0 ].
	^ (self sum: #numberOfDivesIn) / self size
]

{ #category : #helpers }
GTAComputer >> avgNumberOfDivesOut [
	self ifEmpty: [ ^ 0 ].
	^ (self sum: #numberOfDivesOut) / self size
]

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
GTAComputer >> flatCollectEvents: aBlock [ 
	^ self flatCollect: [ :eachSession | eachSession select: aBlock ] as: OrderedCollection
]

{ #category : #testing }
GTAComputer >> hasSessionsWithSpecialKeywords [
	^ self anySatisfy: #hasSpecialKeywords
]

{ #category : #testing }
GTAComputer >> hasSpecialKeywords [
	^ self anySatisfy: #hasSpecialKeywords
]

{ #category : #testing }
GTAComputer >> isDeveloper [
	^ GTAConfiguration isDeveloper: self computerUUID
]

{ #category : #enumerating }
GTAComputer >> missSteps [
	^ self flatCollect: #missSteps as: GTASession
]

{ #category : #helpers }
GTAComputer >> numberOfContextChanged [
	self ifEmpty: [ ^ 0 ].
	^ self sum: #numberOfContextChanged
]

{ #category : #helpers }
GTAComputer >> numberOfDifferentSearchStrings [
	^ self differentSearchStrings size
]

{ #category : #helpers }
GTAComputer >> numberOfDivesIn [
	self ifEmpty: [ ^ 0 ].
	^ self sum: #numberOfDivesIn	
]

{ #category : #helpers }
GTAComputer >> numberOfDivesOut [
	self ifEmpty: [ ^ 0 ].
	^ self sum: #numberOfDivesOut
]

{ #category : #helpers }
GTAComputer >> numberOfEvents [
	self ifEmpty: [ ^ 0 ].
	^ self sum: #size
]

{ #category : #helpers }
GTAComputer >> numberOfPreviews [
	^ self sessionsWithPreview size
]

{ #category : #enumerating }
GTAComputer >> searchStrings [
	^ self flatCollect: #searchStrings as: Bag
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
GTAComputer >> sessionsWithPreview [
	^ self select: #isWithPreview
]

{ #category : #enumerating }
GTAComputer >> sessionsWithSpecialKeywords [
	^ self select: #hasSpecialKeywords
]

{ #category : #enumerating }
GTAComputer >> specialKeywords [
	^ self flatCollect: #specialKeywords as: OrderedCollection
]

{ #category : #update }
GTAComputer >> updateEvents [
	^ self do: #updateEvents
]

{ #category : #accessing }
GTAComputer >> userOrDeveloperString [
	^ self isDeveloper
			ifTrue: [ 'dev' ]
			ifFalse: [ 'user' ]
]

{ #category : #enumerating }
GTAComputer >> userQueryOrSelectionHashes [
	^ self flatCollect: #userQueryOrSelectionHashes as: OrderedCollection
]
