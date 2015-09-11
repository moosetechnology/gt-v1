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
		'context',
		'selected',
		'stream',
		'candidates',
		'asyncTask',
		'spotter',
		'lastSearchContext'
	],
	#category : #'GT-Spotter-Model'
}

{ #category : #example }
GTSpotterStep class >> gtExampleBasic [
	<gtExample>
	^ self new
]

{ #category : #actions }
GTSpotterStep >> actDueTo: anEventType [
	self selected ifNil: [ ^ self ].
	self spotter
		historize: self selected;
		notifyActOn: self selectedCandidate for: anEventType.
	self selected processor actOn: self selectedCandidate for: self

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

	^ asyncTask ifNil: [ asyncTask := self defaultTask ]
]

{ #category : #private }
GTSpotterStep >> basicRelevantProcessorsProcess: aSpotterContext [
	self basicRelevantProcessorsProcess: aSpotterContext do: [ :processor | 
		aSpotterContext processor: processor.
		processor filterInContext: aSpotterContext ]
]

{ #category : #private }
GTSpotterStep >> basicRelevantProcessorsProcess: aSpotterContext do: aBlock [
	aSpotterContext text substrings 
		detect: [ :each | each beginsWith: '#' ]
		ifFound: [ :categoryQuery | 
			| categoryQueryPrefix |
			aSpotterContext text: (aSpotterContext text copyReplaceAll: categoryQuery with: '').
			categoryQueryPrefix := categoryQuery allButFirst asLowercase.
			self processors 
				select: [ :each | each title asLowercase beginsWith: categoryQueryPrefix ]
				thenDo: aBlock ]
		ifNone: [ 
			self processors do: aBlock ]
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
		candidates announcer weak when: GTSpotterCandidateAdded do: [ self candidates hasOnlyOneItem ifTrue: [ self selectFirst ] ].
		candidates announcer weak when: GTSpotterAllCandidatesAdded do: [ self selectFirst ].
		candidates announcer weak when: GTSpotterAllCandidatesRemoved do: [ self selected: nil ].
		candidates ]
]

{ #category : #accessing }
GTSpotterStep >> context [

	^ context ifNil: [ context := self newContextForQuery: nil ]
]

{ #category : #accessing }
GTSpotterStep >> context: aGTSpotterContext [
	context := aGTSpotterContext
]

{ #category : #'accessing-defaults' }
GTSpotterStep >> defaultStream [
	^ GTSpotterUIThreadStream new
]

{ #category : #'accessing-defaults' }
GTSpotterStep >> defaultTask [
	^ GLMAsyncTask new
]

{ #category : #actions }
GTSpotterStep >> diveIn [
	self diveInDueTo: #undefined
]

{ #category : #actions }
GTSpotterStep >> diveInCategory [

	^ self diveInCategoryDueTo: #unknown
	
]

{ #category : #actions }
GTSpotterStep >> diveInCategoryDueTo: anEventType [

	self spotter
		requestNextCategoryStepWith: self selected processorLink;
		notifyDiveInCategory: self selected processor for: anEventType
	
]

{ #category : #actions }
GTSpotterStep >> diveInDueTo: anEventType [
	self canDiveInSelectedCandidate ifTrue: [ 
		self spotter
			historize: self selected;
			requestNextStepWith: self selectedCandidate;
			notifyDiveIn: self selectedCandidate for: anEventType ]
]

{ #category : #'accessing-dynamic' }
GTSpotterStep >> exceptionHandler [
	^ GTCurrentSpotterExceptionHandler value ifNil: [ self spotter exceptionHandler ]
	" #ifNil: is necessary because the sender chain of #spotterProcessorsFor:pragma: may have multiple callees outside of the exception handler (async) ... so we have to provide a global but yet easy fallback "
]

{ #category : #actions }
GTSpotterStep >> exit [

	self spotter exit
]

{ #category : #inspecting }
GTSpotterStep >> gtInspectorProcessorsIn: composite [
	<gtInspectorPresentationOrder: 40>
	composite list
		title: 'Processors';
		display: [ self processors ];
		format: #gtDisplayString
]

{ #category : #testing }
GTSpotterStep >> hasPreviousNavigationFromClass: aClass [

	^ self hasPreviousStep and: [
		self previousStep origin isKindOf: aClass ]
]

{ #category : #testing }
GTSpotterStep >> hasPreviousStep [
	
	^ (self spotter steps indexOf: self) > 1
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

{ #category : #processing }
GTSpotterStep >> newContextForQuery: aString [
	^ GTSpotterContext new 
		step: self;
		stream: self stream;
		text: aString;
		yourself
]

{ #category : #notifying }
GTSpotterStep >> notifySelectedCandidateChanged: aDoubleLink [
	
	^ self notifySelectedCandidateChanged: aDoubleLink for: #unknown
]

{ #category : #notifying }
GTSpotterStep >> notifySelectedCandidateChanged: aDoubleLink for: anEventType [
	|candidate|
	
	candidate := aDoubleLink ifNotNil: [ :o | o value ].
	self announcer announce: (GTSpotterSelectedCandidateChanged new selected: candidate).
	self spotter notifyCandidateSelected: candidate for: anEventType
]

{ #category : #accessing }
GTSpotterStep >> origin [

	^ origin
]

{ #category : #accessing }
GTSpotterStep >> origin: anObject [

	origin := anObject
]

{ #category : #accessing }
GTSpotterStep >> previousProcessorFrom: aCollection [
	aCollection do: [ :each | 
		each asSpotterCandidateLink processor ifNotNil: [ ^ each processor ] ]. " we assume they are all identical "
	^ GTSpotterCandidatesListProcessor new
		title: 'Items';
		filter: GTFilterSubstring;
		yourself
]

{ #category : #'accessing-dynamic' }
GTSpotterStep >> previousStep [
	
	^ self spotter steps at: 
			(self spotter steps indexOf: self) - 1
]

{ #category : #processing }
GTSpotterStep >> process: aString [
	"I do not accept empty queries or the same queries as before.
	If nil is passed, than an empty string will be processed. This approach is used to
	destinguish when user deletes last character in the search and when search field became
	empty after spawning new step"
	
	"no need to search for the same query"
	(self context matches: aString) ifTrue: [ ^ self ].
	self context: (self newContextForQuery: aString).
	
	" updating timestamp in a stream, to prevent candidates from old process being shown "
	self stream updateTimestamp.
	
	self asyncTask
		execute: [ :aCurrentContext |
			self spotter notifyContextChangedFrom: lastSearchContext to: self context.
			self processContext: aCurrentContext ]
		withArguments: { self context. }
		callback: [
			lastSearchContext := self context. 
			self spotter notifySearchFinishedFor: aString processors: self processors ]
		"added small delay before actual searching. It makes spotter faster :)"
		delay: 200
]

{ #category : #processing }
GTSpotterStep >> processContext: aSpotterContext [
	self spotter handleExceptionsDuring: [ 
		self stream removeAllCandidates.
		self relevantProcessorsProcess: aSpotterContext  ]
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

{ #category : #'accessing-dynamic' }
GTSpotterStep >> processorsFilter [

	^ self spotter processorsFilter
]

{ #category : #private }
GTSpotterStep >> relevantProcessorsProcess: aSpotterContext [
	[ self basicRelevantProcessorsProcess: aSpotterContext ]
		on: Error
		do: [ :exception | 
			self exceptionHandler 
				handleException: exception 
				do: [ ('[Spotter] Exception in process: ', exception asString) logCr ] ]
]

{ #category : #selecting }
GTSpotterStep >> selectFirst [
	
	self candidates isEmpty ifTrue: [ ^ self ].
	self selected: self candidates head
]

{ #category : #selecting }
GTSpotterStep >> selectNextCategory [
	|currentCategory nextCategory|
	self selected ifNil: [ ^ self ].
	
	currentCategory := self candidates getProcessorLinkByCandidateLink: self selected.
	nextCategory := self candidates nextProcessorLinkOf: currentCategory.
	
	self selected: ((currentCategory = nextCategory)
		ifTrue: [ nextCategory tailLink ]
		ifFalse: [ nextCategory headLink ])
	
	
]

{ #category : #selecting }
GTSpotterStep >> selectNextDueTo: anEventType [
	
	self selected ifNil: [ ^ self ].
	self selected: self selected nextLink dueTo: anEventType
	
	
]

{ #category : #selecting }
GTSpotterStep >> selectPreviousCategory [
	|currentCategory previousCategory|
	self selected ifNil: [ ^ self ].
	
	currentCategory := self candidates getProcessorLinkByCandidateLink: self selected.
	previousCategory := self candidates previousProcessorLinkOf: currentCategory.
	
	self selected: previousCategory headLink
]

{ #category : #selecting }
GTSpotterStep >> selectPreviousDueTo: anEventType [

	self selected ifNil: [ ^ self ].
	self selected: self selected previousLink dueTo: anEventType
]

{ #category : #accessing }
GTSpotterStep >> selected [

	^ selected ifNil: [
		selected := (self candidates isEmpty
			ifTrue: [ ^ nil ]
			ifFalse: [ self candidates head ]).
		self notifySelectedCandidateChanged: selected.
		selected ifNotNil: [ self spotter notifyCategorySelected: self selected processor ].
		selected ]
]

{ #category : #selecting }
GTSpotterStep >> selected: aDoubleLink [
	
	^ self selected: aDoubleLink dueTo: #unknown
	
	
]

{ #category : #selecting }
GTSpotterStep >> selected: aDoubleLink dueTo: anEvenType [
	
	self selected = aDoubleLink ifTrue: [ ^ self ].
	
	self spotter
		after: [
			selected := aDoubleLink.
			self notifySelectedCandidateChanged: selected for: anEvenType]
		do: [ self spotter notifyCategorySelected: self selected processor ]
		ifTrue: [ aDoubleLink
			ifNotNil: [ self selected
				ifNotNil: [ (self selected processor = aDoubleLink processor) not ]
				ifNil: [ true ] ]
			ifNil: [ false ] ]
	
	
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
		stream := self defaultStream.
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
