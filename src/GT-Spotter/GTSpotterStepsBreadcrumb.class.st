Class {
	#name : #GTSpotterStepsBreadcrumb,
	#superclass : #GLMBrick,
	#instVars : [
		'spotterModel',
		'items',
		'band'
	],
	#category : #'GT-Spotter-UI'
}

{ #category : #'adding/removing' }
GTSpotterStepsBreadcrumb >> addItem: aBrick [

	self items size = 1 ifTrue: [
		self items first labelBrick layout paddingLeft: self theme spotterWidgetThemer breadcrumbSeparatorWidth / 2 ].
	self band addBrickBack: aBrick.
	self items addLast: aBrick
]

{ #category : #'adding/removing' }
GTSpotterStepsBreadcrumb >> addSeparator [
	|separator|
	separator := self newSeparator.
	self theme spotterWidgetThemer breadcrumbSeparatorStyleFor: separator.
	self band addBrickBack: separator
]

{ #category : #accessing }
GTSpotterStepsBreadcrumb >> band [

	^ band
]

{ #category : #accessing }
GTSpotterStepsBreadcrumb >> band: aBrick [

	band := aBrick.
	band layoutPolicy: (GLMBrickHorizontalFillLinearLayout new).
	band width: [ :bandBrick |
		self items isEmpty ifTrue: [ 0 ]
			ifFalse: [ |width|
				width := 0.
				self items do: [ :each | width := width + each width ].
				width + ((self items size - 1) * self theme spotterWidgetThemer breadcrumbSeparatorWidth)] ].
	
	self band data: 0.
	self addBrickBack: band.
]

{ #category : #geometry }
GTSpotterStepsBreadcrumb >> calculateItemWidth: aBrick [
	|sWidth bWidth|
	sWidth := self theme spotterWidgetThemer breadcrumbSeparatorWidth.
	bWidth := self width.
	
	"width of other bricks depends from the width of the last one"
	^ aBrick isLastInOwner
		ifTrue: [ ((aBrick labelBrick approximateWidth min: (bWidth / 2)) max: ((bWidth - ((self maxNumberOfSteps - 1) * sWidth)) / self maxNumberOfSteps)) floor ]
		ifFalse: [ ((bWidth - self band lastSubbrick width - ((self maxNumberOfSteps - 1) * sWidth)) / (self maxNumberOfSteps - 1)) floor ]
	
]

{ #category : #accessing }
GTSpotterStepsBreadcrumb >> defaultBreadcrumbHeight [

	^ self theme spotterWidgetThemer breadcrumbHeight + self theme spotterWidgetThemer breadcrumbTriangleHeight
]

{ #category : #'as yet unclassified' }
GTSpotterStepsBreadcrumb >> doLayout [
	super doLayout.
	
	self scrollToTheLastOne: false
]

{ #category : #geometry }
GTSpotterStepsBreadcrumb >> glmAnimateBrickBounds: aValue duration: anInteger callback: aBlock [

	anInteger <= 0
		"if duration is zero, move to the left immediately"
		ifTrue: [ self leftTo: aValue ]
		ifFalse: [
			| startTime start currentValue startBounds|
			currentValue := 0.
			startBounds := self band brickBounds.
			startTime := Time millisecondClockValue.
			start := currentValue.
			[	| delta translate|
				[ (delta := Time millisecondClockValue - startTime) < anInteger ] whileTrue: [
					translate := (aValue - start) * (delta / anInteger) + start.
					self band brickBounds: (startBounds translateBy: translate@0).
					self changed.
					Processor yield
				].
				self band brickBounds: (startBounds translateBy: aValue@0).
				self changed.
				Processor yield.
				aBlock ifNotNil: [ aBlock value ].
			] fork
		]
]

{ #category : #initialization }
GTSpotterStepsBreadcrumb >> initialize [
	super initialize.
	
	self
		layout: GLMBrickHorizontalFillLinearLayout new;
		band: self newBand;
		height: [ self items isEmpty ifTrue: [ 0 ] ifFalse: [ self defaultBreadcrumbHeight ] ]
	
]

{ #category : #testing }
GTSpotterStepsBreadcrumb >> isVisible [

	^ self items isEmpty not
]

{ #category : #accessing }
GTSpotterStepsBreadcrumb >> items [

	^ items ifNil: [ items := OrderedCollection new ]
]

{ #category : #accessing }
GTSpotterStepsBreadcrumb >> maxNumberOfSteps [
	^ 5
]

{ #category : #'instance creation' }
GTSpotterStepsBreadcrumb >> newBand [

	^ GLMBrick new
]

{ #category : #'instance creation' }
GTSpotterStepsBreadcrumb >> newSeparator [

	^ GLMBrick new
]

{ #category : #notifying }
GTSpotterStepsBreadcrumb >> notifyBreadcrumbVisibilityChanged [

	self announcer announce: GTSpotterBreadcrumbVisibilityChanged new
]

{ #category : #'events-processing' }
GTSpotterStepsBreadcrumb >> onStepAdded: ann [
	|step origin previousStep selectedCandidate|
	
	self spotterModel steps size <= 1 ifTrue: [ ^ self push: (GTSpotterStepBreadcrumbItem new text: 'Spotter') ].
	
	step := ann stepModel.
	previousStep := (step spotter steps at: step spotter steps size - 1).
	selectedCandidate := previousStep selectedCandidate.
	origin := step origin.
	
	self push: (GTSpotterStepBreadcrumbItem new
		text: ((selectedCandidate = origin)
			ifTrue: [ (previousStep selected renderingProcessor render: selectedCandidate) labelBrick text ]
			ifFalse: [ (origin isKindOf: Collection) ifTrue: [ previousStep selected processor title ] ifFalse: [ origin gtDisplayString] ]))
]

{ #category : #'events-processing' }
GTSpotterStepsBreadcrumb >> onStepPopped [

	self pop
	
]

{ #category : #'adding/removing' }
GTSpotterStepsBreadcrumb >> pop [

	self band removeBrick: self items last.
	self items removeLast.
	
	self items size = 1 ifTrue: [
		self items first labelBrick layout paddingLeft: 0 ].
	
	self items isEmpty ifFalse: [ self popSeparator ].
	
	"optimization. if last item was popped we need to update root to reposition all brick,
	otherwise only I need to be updated"
	self items size = 0
		ifTrue: [ self notifyBreadcrumbVisibilityChanged ]
		ifFalse: [
			self items last showTriangle.
			super doLayout.
			self scrollToTheLastOne.
			self changed ]
]

{ #category : #'adding/removing' }
GTSpotterStepsBreadcrumb >> popSeparator [

	self band removeBrick: self band lastSubbrick
]

{ #category : #'adding/removing' }
GTSpotterStepsBreadcrumb >> push: aBrick [

	self theme spotterWidgetThemer breadcrumbItemStyleFor: aBrick.
	
	aBrick width: [ :itemBrick | self calculateItemWidth: itemBrick ].
	
	self items isEmpty ifFalse: [
		self items last hideTriangle.
		self addSeparator ].
	
	self addItem: aBrick.
	
	"optimization. if first item was added we need to update root to reposition all bricks,
	otherwise only I need to be updated"
	self items size = 1
		ifTrue: [ self notifyBreadcrumbVisibilityChanged ]
		ifFalse: [
			super doLayout.
			self scrollToTheLastOne.
			self changed ].
	
]

{ #category : #geometry }
GTSpotterStepsBreadcrumb >> scrollToTheLastOne [

	self scrollToTheLastOne: true
	
	
]

{ #category : #geometry }
GTSpotterStepsBreadcrumb >> scrollToTheLastOne: isAnimated [
	|leftDelta rightDelta delta|
	self items isEmpty ifTrue: [ ^ self ].
	
	self band translateX: self band data.
	
	rightDelta := self globalBounds right - self band globalBounds right.
	leftDelta := self globalBounds left - self band globalBounds left.
			
	"all visible, return"
	(leftDelta = 0  and: [ self items size <= self maxNumberOfSteps ]) ifTrue: [ ^ self ].
	
	delta := (self items size <= self maxNumberOfSteps) ifTrue: [leftDelta] ifFalse: [rightDelta].
	self band data: (self band data + delta).

	isAnimated ifFalse: [ ^ self band translateX: delta ].
	
	self
		glmAnimateBrickBounds: delta
		duration: 400
		callback: nil.
	
	
]

{ #category : #accessing }
GTSpotterStepsBreadcrumb >> spotterModel [
	^ spotterModel
]

{ #category : #accessing }
GTSpotterStepsBreadcrumb >> spotterModel: aSpotterModel [
	
	spotterModel := aSpotterModel.
	
	spotterModel announcer weak subscribe: GTSpotterStepAdded send: #onStepAdded: to: self.
	spotterModel announcer weak subscribe: GTSpotterStepPopped send: #onStepPopped to: self.
]
