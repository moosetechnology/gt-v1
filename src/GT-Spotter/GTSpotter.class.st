"
This is the main model class.

It handles the steps of the search, and it handles the search text.
"
Class {
	#name : #GTSpotter,
	#superclass : #Object,
	#instVars : [
		'foundationOrigin',
		'steps',
		'announcer',
		'currentStep',
		'pagerModel',
		'text',
		'isPreviewVisible',
		'isShiftPressed'
	],
	#classInstVars : [
		'history',
		'isPreviewVisible',
		'wasOpened'
	],
	#category : #'GT-Spotter-Model'
}

{ #category : #cleanup }
GTSpotter class >> cleanUp [
    self resetHistory.
	wasOpened := false
]

{ #category : #accessing }
GTSpotter class >> dontShowPreview [

	isPreviewVisible := false
]

{ #category : #example }
GTSpotter class >> exampleInWindow [
	
	^ GTSpotterMorph new
		extent: 400@500;
		doLayout;
		spotterModel: self new;
		openInWindow
]

{ #category : #example }
GTSpotter class >> exampleMC [
	"self exampleMC"
	
	^ GTSpotterMorph new
		extent: 400@500;
		doLayout;
		spotterModel: (self on: MCWorkingCopy allManagers);
		openCenteredInWorld
]

{ #category : #example }
GTSpotter class >> exampleWithPreview [
	^ GTSpotterMorph new
		extent: (World width / 2.5 @ (World height / 1.5)) asIntegerPoint;
		spotterModel: self new;
		showPreview;
		openCenteredInWorld
]

{ #category : #example }
GTSpotter class >> exampleWorldMenu [
	
	^ GTSpotterMorph new
		extent: 400@500;
		doLayout;
		spotterModel: (self on: World worldMenu);
		openCenteredInWorld
]

{ #category : #inspecting }
GTSpotter class >> gtInspectorExtensionsIn: composite [
	<gtInspectorPresentationOrder: 40>
	composite list
		title: 'Extensions';
		display: [ self spotterExtendingMethods ];
		showOnly: 50;
		format: [ :each | each gtDisplayString ];
		filterOn: [ :text :each | each gtDisplayString includesSubstring: text caseSensitive: false ]
]

{ #category : #accessing }
GTSpotter class >> history [
	^ history ifNil: [ history := WeakOrderedCollection new ]
]

{ #category : #testing }
GTSpotter class >> isPreviewVisible [

	^ isPreviewVisible ifNil: [ isPreviewVisible := false ]
]

{ #category : #accessing }
GTSpotter class >> markOpened [

	wasOpened := true
]

{ #category : #'instance creation' }
GTSpotter class >> on: anObject [
	
	^ self new foundationOrigin: anObject
]

{ #category : #accessing }
GTSpotter class >> resetHistory [
	"
	self resetHistory
	"
	^ history := nil
]

{ #category : #accessing }
GTSpotter class >> showPreview [

	isPreviewVisible := true
]

{ #category : #inspecting }
GTSpotter class >> spotterExtendingMethods [
	^(Object withAllSubclasses
		flatCollect: [ :each | 
			(Pragma allNamed: #spotterOrder: in: each) 
				collect: [ :p | p method asRingDefinition ] ])
		sorted
]

{ #category : #testing }
GTSpotter class >> wasOpened [

	^ wasOpened ifNil: [ false ]
]

{ #category : #'actions api' }
GTSpotter >> addStep: aStepModel [

	self steps add: aStepModel.
	self notifyStepAdded: aStepModel
]

{ #category : #'actions api' }
GTSpotter >> after: afterBlock do: doBlock ifTrue: conditionBlock [
	|value|
	value := conditionBlock brickValue: self.
	afterBlock brickValue: self.
	value ifTrue: [ doBlock brickValue: value ]
]

{ #category : #'actions api' }
GTSpotter >> after: afterBlock do: doBlock with: withBlock [
	|value|
	value := withBlock brickValue: self.
	afterBlock brickValue: self.
	doBlock brickValue: value
]

{ #category : #notifying }
GTSpotter >> announce: anAnnouncement [
	
	self announcer announce: anAnnouncement
]

{ #category : #accessing }
GTSpotter >> announcer [

	^ announcer ifNil: [ announcer := Announcer new ]
]

{ #category : #accessing }
GTSpotter >> currentStep [
	
	^ currentStep ifNil: [ 
			self isEmpty 
				ifTrue: [ self newStep origin: self foundationOrigin ]
				ifFalse: [ currentStep := self steps last ] ]
]

{ #category : #accessing }
GTSpotter >> currentStep: aStepModel [
	
	currentStep := aStepModel.
	self notifyCurrentStepChanged
]

{ #category : #'accessing-defaults' }
GTSpotter >> defaultPagerModel [
	^ GLMPagerModel new
]

{ #category : #'accessing-defaults' }
GTSpotter >> defaultStep [
	^ GTSpotterStep new
]

{ #category : #'actions api' }
GTSpotter >> exit [

	self notifySpotterExit
]

{ #category : #accessing }
GTSpotter >> foundationOrigin [
	
	^ foundationOrigin ifNil: [ foundationOrigin := self ]
]

{ #category : #accessing }
GTSpotter >> foundationOrigin: anObject [
	
	foundationOrigin := anObject
]

{ #category : #'model access' }
GTSpotter >> getText [

	^ self text
]

{ #category : #printing }
GTSpotter >> gtDisplayOn: stream [

	stream nextPutAll: 'Spotter'
]

{ #category : #testing }
GTSpotter >> hasPreviousStep [

	^ self steps size > 1
]

{ #category : #'actions api' }
GTSpotter >> hidePreview [

	self isPreviewVisible ifFalse: [ ^ self ].
	isPreviewVisible := false.
	self class dontShowPreview.
	self notifyHidePreview
	
]

{ #category : #'actions api' }
GTSpotter >> historize: target [

	(target = self or: [ target isNil ])
		ifFalse: [ 
			self class history remove: target ifAbsent: [].
			self class history addFirst: target ]
]

{ #category : #testing }
GTSpotter >> isEmpty [

	^ self steps isEmpty
]

{ #category : #testing }
GTSpotter >> isPreviewVisible [

	^ isPreviewVisible ifNil: [ isPreviewVisible := false ]
]

{ #category : #accessing }
GTSpotter >> isShiftPressed [

	^ isShiftPressed ifNil: [ isShiftPressed := false ]
]

{ #category : #protocol }
GTSpotter >> menu [

	^ nil
]

{ #category : #'instance creation' }
GTSpotter >> newStep [

	^ self defaultStep
		spotter: self
]

{ #category : #notifying }
GTSpotter >> notifyActOn: anObject for: anEventType [

	self announce: (GTSpotterActOn new 
		element: anObject;
		eventType: anEventType)
]

{ #category : #notifying }
GTSpotter >> notifyCandidateSelected: anObject [

	self announce: (GTSpotterSelectedCandidateChanged new selected: anObject)
]

{ #category : #notifying }
GTSpotter >> notifyCategorySelected: aProcessor [

	self announce: (GTSpotterCategorySelected new category: aProcessor)
]

{ #category : #notifying }
GTSpotter >> notifyContextChangedFrom: aPreviousContext to: aCurrentContext [
	self announce: (GTSpotterContextChanged new
		previous: aPreviousContext;
		current: aCurrentContext;
		yourself)
]

{ #category : #notifying }
GTSpotter >> notifyCurrentStepChanged [

	self announce: GTSpotterCurrentStepChanged new
]

{ #category : #notifying }
GTSpotter >> notifyDiveIn: anObject for: anEventType [

	self announce: (GTSpotterDiveInElement new 
		element: anObject;
		eventType: anEventType )
]

{ #category : #notifying }
GTSpotter >> notifyDiveInCategory: aProcessor for: anEventType [

	self announce: (GTSpotterDiveInCategory new 
		category: aProcessor;
		eventType: anEventType)
]

{ #category : #notifying }
GTSpotter >> notifyDiveOut: anObject [

	self announce: (GTSpotterDiveOut new element: anObject)
]

{ #category : #notifying }
GTSpotter >> notifyHideHints [

	self announce: GTSpotterHideHints new
]

{ #category : #notifying }
GTSpotter >> notifyHidePreview [

	self announce: GTSpotterHidePreview new
]

{ #category : #notifying }
GTSpotter >> notifyRevealHints [

	self announce: GTSpotterRevealHints new
]

{ #category : #notifying }
GTSpotter >> notifySearchFinishedFor: aString processors: aCollectionOfProcessors [

	self announce: (GTSpotterSearchFinished new 
								query: aString;
								processors: aCollectionOfProcessors;
								yourself)
]

{ #category : #notifying }
GTSpotter >> notifyShowPreview [

	self announce: GTSpotterShowPreview new

	
]

{ #category : #notifying }
GTSpotter >> notifySpotterExit [

	self announce: GTSpotterExitAnnouncement new
]

{ #category : #notifying }
GTSpotter >> notifyStepAdded: aStep [

	self announce: (GTSpotterStepAdded new stepModel: aStep)
]

{ #category : #notifying }
GTSpotter >> notifyStepPopped [

	self announce: GTSpotterStepPopped new
]

{ #category : #'event handling' }
GTSpotter >> onPagePopped [
	
	self steps size > 0 ifTrue: [
		self currentStep: self steps last ]
]

{ #category : #accessing }
GTSpotter >> pagerModel [

	^ pagerModel ifNil: [
		pagerModel := self defaultPagerModel defaultNumberOfVisiblePages: 1.
		pagerModel announcer subscribe: GLMPagePoped send: #onPagePopped to: self.
		pagerModel ]
]

{ #category : #'actions api' }
GTSpotter >> popStep [

	"there always should be minimum one step left"
	(self steps size > 1)
		ifTrue: [
			self
				after: [ self steps removeLast ]
				do: [ :o | self notifyDiveOut: o ]
				with: self currentStep origin.
			self notifyStepPopped.
			"perform pane popping only after we scrolled to the penultimate pane, so user doesn't see blinking"
			self pagerModel
				scrollToPane: self steps size
				callback: [ self pagerModel popPane: false ] ]
]

{ #category : #'actions api' }
GTSpotter >> popUntil: aStep [

	[ self steps last = aStep ]
		whileFalse: [ self popStep ]
]

{ #category : #accessing }
GTSpotter >> previousStep [
	
	^ self steps size > 1 
		ifTrue: [ self steps reversed second ]
]

{ #category : #'actions api' }
GTSpotter >> pushStep: stepModel [
	
	self addStep: stepModel.
	"updating current step"
	self currentStep: stepModel
]

{ #category : #'event handling' }
GTSpotter >> requestNextCategoryStepWith: aProcessorLink [
	|collection|
	
	collection := aProcessorLink processor allFilteredCandidates
		collect: [ :each | each asSpotterCandidateLink renderingProcessor: aProcessorLink ].
		
	self requestNextStepWith: collection
]

{ #category : #'event handling' }
GTSpotter >> requestNextStepWith: origin [

	text := ''.
	self pushStep: (self newStep origin: origin; yourself).
	self steps last process: nil
]

{ #category : #'model access' }
GTSpotter >> setText: aText from: aView [

	self steps isEmpty
		"by default there are no steps, so we need to create one based on foundation origin"
		ifTrue: [ self addStep: ( self newStep origin: self foundationOrigin ) ].

	(aText asString isEmpty and: [ self text isEmpty not ])
		ifTrue: [ self currentStep process: nil ]
		ifFalse: [ self currentStep process: aText asString ].
	
	text := aText asString asText.
	^ true
]

{ #category : #'actions api' }
GTSpotter >> shiftPressed: aBoolean [

	self isShiftPressed = aBoolean ifTrue: [ ^ self ].
	
	isShiftPressed := aBoolean.
	
	SmalltalkImage current vm interpreterSourceDate < 2015 asYear 
		ifTrue: [ ^ isShiftPressed := false ].

	self isShiftPressed
		ifTrue: [ self notifyRevealHints ]
		ifFalse: [ self notifyHideHints ]

	
]

{ #category : #'actions api' }
GTSpotter >> showPreview [

	self isPreviewVisible ifTrue: [ ^ self ].
	isPreviewVisible := true.
	self class showPreview.
	self notifyShowPreview
	
]

{ #category : #accessing }
GTSpotter >> steps [

	^ steps ifNil: [ steps := OrderedCollection new ]
]

{ #category : #'actions api' }
GTSpotter >> terminateProcessors [

	self steps do: [ :each | each terminateProcessors ]
]

{ #category : #accessing }
GTSpotter >> text [

	^ text ifNil: [ text := '' asText ]
]

{ #category : #'actions api' }
GTSpotter >> togglePreview [

	self isPreviewVisible
		ifTrue: [ self hidePreview ]
		ifFalse: [ self showPreview ]
]
