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
		'asyncTask',
		'spotter',
		'isCategorySelected'
	],
	#category : #'GT-Spotter-Model'
}

{ #category : #actions }
GTSpotterStep >> act [
	|processor|
	self selected ifNil: [ ^ self ].
	processor := (self candidates getProcessorLinkByCandidateLink: self selected) processor.
	self spotter historize: self selected.
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
GTSpotterStep >> asyncTask [

	^ asyncTask ifNil: [ asyncTask := GTAsyncTask new ]
]

{ #category : #actions }
GTSpotterStep >> canDiveIn: aCandidate [
	| newFakeStep |
	newFakeStep := self spotter newStep origin: self origin.
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
		candidates announcer weak subscribe: GTSpotterCandidateAdded do: [ self selectFirst ].
		candidates announcer weak subscribe: GTSpotterAllCandidatesAdded do: [ self selectFirst ].
		candidates ]
]

{ #category : #actions }
GTSpotterStep >> diveIn [
	self canDiveInSelectedCandidate ifTrue: [ 
		self spotter historize: self selected.
		self spotter requestNextStepWith: self selectedCandidate ]
]

{ #category : #actions }
GTSpotterStep >> diveInCategory [
	| processorLink |
	processorLink := (self candidates getProcessorLinkByCandidateLink: self selected).
	self spotter requestNextStepWith: (processorLink processor allFilteredCandidates collect: [ :each | each asSpotterCandidateLink renderingProcessor: processorLink ])
]

{ #category : #actions }
GTSpotterStep >> exit [
	self spotter exit
]

{ #category : #testing }
GTSpotterStep >> isCategorySelected [

	^ isCategorySelected ifNil: [ isCategorySelected := Morph new activeHand shiftPressed ]
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
GTSpotterStep >> notifyCategorySelectedOrDeselected [

	self isCategorySelected
		ifTrue: [ self announcer announce: GTSpotterCategorySelected new ]
		ifFalse: [ self announcer announce: GTSpotterCategoryDeselected new ]
]

{ #category : #notifying }
GTSpotterStep >> notifySelectedCandidateChanged [

	self announcer announce: (GTSpotterSelectedCandidateChanged new selected: self selectedCandidate).
	self spotter announcer announce: (GTSpotterSelectedCandidateChanged new selected: self selectedCandidate).
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
	If nil is passed, than an empty string will be processed. This approach is used to
	destinguish when user deletes last character in the search and when search field became
	empty after spawning new step"
	
	"no need to search for the same query"
	(self query isNotEmpty and: [ aString = self query ]) ifTrue: [ ^ self ].
	
	self query: (aString ifNil: [ '' ]).
	"updating timestamp in a stream, to prevent candidates from old process being shown"
	self stream updateTimestamp.
	
	self asyncTask
		execute: [ :input |
				self stream removeAllCandidates.
				[ self relevantProcessorsProcess: input ]
					on: Exception
					do: [ :e | ('[Spotter] Exception in process: ', e asString) logCr ] ]
		withArguments: { self query }
		callback: [  ]
		"added small delay before actual searching. It makes spotter faster :)"
		delay: 200
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

{ #category : #accessing }
GTSpotterStep >> relevantProcessorsFor: aQueryString do: aBlock [
	aQueryString substrings 
		detect: [ :each | each beginsWith: '#' ]
		ifFound: [ :categoryQuery | 
			self processors 
				select: [ :each | each title beginsWith: categoryQuery allButFirst ]
				thenDo: [ :processor | 
					processor 
						filter: (aQueryString copyReplaceAll: categoryQuery with: '') 
						on: self stream ] ]
		ifNone: [ 
			self processors do: [ :processor | 
				processor 
					filter: aQueryString 
					on: self stream ]]
]

{ #category : #accessing }
GTSpotterStep >> relevantProcessorsProcess: aQueryString [
	aQueryString substrings 
		detect: [ :each | each beginsWith: '#' ]
		ifFound: [ :categoryQuery | 
			self processors 
				select: [ :each | each title asLowercase beginsWith: categoryQuery allButFirst asLowercase ]
				thenDo: [ :processor | 
					processor 
						filter: (aQueryString copyReplaceAll: categoryQuery with: '') 
						on: self stream ] ]
		ifNone: [ 
			self processors do: [ :processor | 
				processor 
					filter: aQueryString 
					on: self stream ]]
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
GTSpotterStep >> selectedCategory [

	^ self selected processor
]

{ #category : #actions }
GTSpotterStep >> shiftPressed [

	isCategorySelected := self isCategorySelected not.
	self notifyCategorySelectedOrDeselected
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

	self asyncTask terminate
]
