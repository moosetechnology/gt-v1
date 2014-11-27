"
It models one step in the spotter search.

A step knows:
- the origin object 
- the active processors that handle the query, and the candidates
- the selected candidate, and
- the list of all filtered candidates

It also knows the stream through which the list of candidates is affected.

The key method is process:
"
Class {
	#name : #GTSpotterStep,
	#superclass : #Object,
	#instVars : [
		'announcer',
		'processors',
		'origin',
		'query',
		'selected',
		'stream',
		'candidates',
		'asyncTasks',
		'spotter'
	],
	#category : #'GT-Spotter-Model'
}

{ #category : #actions }
GTSpotterStep >> act [
	|processor|
	self selected ifNil: [ ^ self ].
	processor := (self candidates getProcessorLinkByCandidateLink: self selected) processor.
	processor actOn: self selectedCandidate for: self.
]

{ #category : #accessing }
GTSpotterStep >> addProcessor: aProcessor [

	self processors add: aProcessor
]

{ #category : #accessing }
GTSpotterStep >> announcer [

	^ announcer ifNil: [ announcer := Announcer new ]
]

{ #category : #accessing }
GTSpotterStep >> asyncTaskFor: aProcessor [

	^ self asyncTasks at: aProcessor ifAbsentPut: [ GTAsyncTask new ]
]

{ #category : #accessing }
GTSpotterStep >> asyncTasks [

	^ asyncTasks ifNil: [ asyncTasks := HashTable new ]
]

{ #category : #actions }
GTSpotterStep >> canDiveIn: aCandidate [
	| newFakeStep |
	newFakeStep := self spotter newStep.
	aCandidate spotterProcessorsFor: newFakeStep.
	^ newFakeStep processors notEmpty
]

{ #category : #actions }
GTSpotterStep >> canDiveInSelectedCandidate [

	^ self canDiveIn: self selectedCandidate
]

{ #category : #accessing }
GTSpotterStep >> candidates [

	^ candidates ifNil: [
		candidates := GTSpotterCandidatesList new.
		candidates announcer subscribe: GTSpotterCandidateAdded do: [ self selectFirst ].
		candidates ]
]

{ #category : #actions }
GTSpotterStep >> diveIn [
	self canDiveInSelectedCandidate ifTrue: [ 
		self spotter requestNextStepWith: self selectedCandidate ]
]

{ #category : #actions }
GTSpotterStep >> diveInCategory [
	| processor |
	self flag: 'this is a little bit better than terrible'.
	processor := (self candidates getProcessorLinkByCandidateLink: self selected) processor.
	self spotter requestNextStepWith: processor allFilteredCandidates
]

{ #category : #actions }
GTSpotterStep >> exit [
	self spotter exit
]

{ #category : #testing }
GTSpotterStep >> isEmpty [

	^ self candidates isEmpty
]

{ #category : #accessing }
GTSpotterStep >> listProcessor [
	| processor |
	processor := GTSpotterCandidatesListProcessor new.
	self addProcessor: processor.
	^ processor
]

{ #category : #notifying }
GTSpotterStep >> notifySelectedCandidateChanged [

	self announcer announce: (GTSpotterSelectedCandidateChanged new selected: self selectedCandidate)
]

{ #category : #accessing }
GTSpotterStep >> origin [

	^ origin
]

{ #category : #accessing }
GTSpotterStep >> origin: anObject [

	origin := anObject
]

{ #category : #processing }
GTSpotterStep >> process: aString [
	"I do not accept empty queries or the same queries as before.
	I nil is passed, than an empty string will be processed. This approach is used to
	destinguish when user deletes last character in the search and when search field became
	empty after spawning new step"

	self query: (aString ifNil: [ '' ]).
	self processors do: [ :processor |
		(self asyncTaskFor: processor)
			execute: [ :input | processor filter: input on: self stream ]
			withArguments: { self query }
			callback: [  ] ].
]

{ #category : #accessing }
GTSpotterStep >> processors [

	^ processors ifNil: [ 
		processors := OrderedCollection new.
		self origin spotterProcessorsFor: self.
		"this is a hack. we do it here just because we need to store the
		category name in the brick after the processors have been created"
		processors do: [ :each | 				
			self candidates addProcessor: each ].
		processors ]
]

{ #category : #accessing }
GTSpotterStep >> processors: aCollection [

	processors := aCollection
]

{ #category : #accessing }
GTSpotterStep >> query [

	^ query ifNil: [ query := '' ]
]

{ #category : #accessing }
GTSpotterStep >> query: aString [

	query := aString
]

{ #category : #selecting }
GTSpotterStep >> selectFirst [
	
	self candidates isEmpty ifTrue: [ ^ self ].
	
	selected := self candidates head.
	self notifySelectedCandidateChanged.
]

{ #category : #selecting }
GTSpotterStep >> selectNext [
	
	self selected ifNil: [ ^ self ].
	
	selected := self selected nextLink.
	self notifySelectedCandidateChanged.
	
	
]

{ #category : #selecting }
GTSpotterStep >> selectNextCategory [
	|currentCategory nextCategory|
	self selected ifNil: [ ^ self ].
	
	currentCategory := self candidates getProcessorLinkByCandidateLink: self selected.
	nextCategory := self candidates nextProcessorLinkOf: currentCategory.
	
	selected := (currentCategory = nextCategory)
		ifTrue: [ nextCategory tailLink ]
		ifFalse: [ nextCategory headLink ].
	
	self notifySelectedCandidateChanged.
	
	
]

{ #category : #selecting }
GTSpotterStep >> selectPrevious [

	self selected ifNil: [ ^ self ].
	
	selected := self selected previousLink.
	self notifySelectedCandidateChanged.
]

{ #category : #selecting }
GTSpotterStep >> selectPreviousCategory [
	|currentCategory previousCategory|
	self selected ifNil: [ ^ self ].
	
	currentCategory := self candidates getProcessorLinkByCandidateLink: self selected.
	previousCategory := self candidates previousProcessorLinkOf: currentCategory.
	
	selected := previousCategory headLink.
	
	self notifySelectedCandidateChanged.
	
	
]

{ #category : #accessing }
GTSpotterStep >> selected [

	^ selected ifNil: [
		selected := self candidates isEmpty
			ifTrue: [ nil ]
			ifFalse: [ self candidates head ] ]
]

{ #category : #accessing }
GTSpotterStep >> selected: aDoubleLink [

	selected := aDoubleLink.
	self notifySelectedCandidateChanged
]

{ #category : #accessing }
GTSpotterStep >> selectedCandidate [

	^ self selected
		ifNotNil: [ self selected value ]
		ifNil: [ nil ]
]

{ #category : #accessing }
GTSpotterStep >> spotter [
	^ spotter
]

{ #category : #accessing }
GTSpotterStep >> spotter: aSpotter [
	spotter := aSpotter 
]

{ #category : #accessing }
GTSpotterStep >> stream [

	^ stream ifNil: [
		stream := GTSpotterUIThreadStream new.
		stream
			onAddedSelector: #addCandidate:in:;
			onRemoveSelector: #removeAllCandidatesOf:;
			receiver: self candidates.
		stream ]
]

{ #category : #actions }
GTSpotterStep >> terminateProcessors [

	self asyncTasks do: [ :each | each terminate ]
]
