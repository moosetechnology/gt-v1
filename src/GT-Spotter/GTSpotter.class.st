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
		'isPreviewVisible'
	],
	#classInstVars : [
		'history',
		'isPreviewVisible'
	],
	#category : #'GT-Spotter-Model'
}

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

{ #category : #accessing }
GTSpotter class >> isPreviewVisible [

	^ isPreviewVisible ifNil: [ isPreviewVisible := false ]
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

{ #category : #'actions api' }
GTSpotter >> addStep: aStepModel [
	self steps add: aStepModel.
	self notifyStepAdded: aStepModel
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

{ #category : #'actions api' }
GTSpotter >> exit [

	self announcer announce: (GTSpotterExitAnnouncement new)
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
	self announcer announce: GTSpotterHidePreview new.
	
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

{ #category : #protocol }
GTSpotter >> menu [
	^ nil
]

{ #category : #'instance creation' }
GTSpotter >> newStep [

	^ GTSpotterStep new 
		spotter: self
]

{ #category : #notifying }
GTSpotter >> notifyCurrentStepChanged [

	self announcer announce: (GTSpotterCurrentStepChanged new)
]

{ #category : #notifying }
GTSpotter >> notifyStepAdded: aStep [

	self announcer announce: (GTSpotterStepAdded new stepModel: aStep)
]

{ #category : #notifying }
GTSpotter >> notifyStepPopped [

	self announcer announce: (GTSpotterStepPopped new)
]

{ #category : #'event handling' }
GTSpotter >> onPagePopped [
	
	self steps size > 0 ifTrue: [
		self currentStep: self steps last ]
]

{ #category : #accessing }
GTSpotter >> pagerModel [

	^ pagerModel ifNil: [
		pagerModel := GLMPagerModel new defaultNumberOfVisiblePages: 1.
		pagerModel announcer subscribe: GLMPagePoped send: #onPagePopped to: self.
		pagerModel ]
]

{ #category : #'actions api' }
GTSpotter >> popStep [

	"there always should be minimum one step left"
	(self steps size > 1)
		ifTrue: [ |origin|
			origin := self currentStep origin.
			self steps removeLast.
			self notifyStepPopped.
			self announcer announce: (GTSpotterDiveOut new element: origin).
			"perform pane popping only after we scrolled to the penultimate pane, so user doesn't see blinking"
			self pagerModel
				scrollToPane: (self steps size)
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
GTSpotter >> showPreview [

	self isPreviewVisible ifTrue: [ ^ self ].
	isPreviewVisible := true.
	self class showPreview.
	self announcer announce: GTSpotterShowPreview new.
	
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
