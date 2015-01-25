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
				self items do: [ :each | width := width + each width + each layoutProperties marginRight ].
				width - self items last layoutProperties marginRight ] ].
	
	self band data: 0.
	self addBrickBack: band.
]

{ #category : #geometry }
GTSpotterStepsBreadcrumb >> calculateItemWidth: aBrick [
	
	"width of other bricks depends from the width of the last one"
	^ aBrick isLastInOwner
		ifTrue: [ ((aBrick labelBrick approximateWidth min: (self width / 2)) max: ((self width - ((self maxNumberOfSteps - 1) * aBrick layoutProperties marginRight)) / self maxNumberOfSteps)) floor ]
		ifFalse: [ ((self width - self band lastSubbrick width - ((self maxNumberOfSteps - 1) * aBrick layoutProperties marginRight)) / (self maxNumberOfSteps - 1)) floor ]
	
]

{ #category : #accessing }
GTSpotterStepsBreadcrumb >> defaultBreadcrumbHeight [

	^ self theme spotterWidgetThemer breadcrumbHeight + self theme spotterWidgetThemer breadcrumbTriangleHeight
]

{ #category : #geometry }
GTSpotterStepsBreadcrumb >> doLayout [
	super doLayout.
		
	self scrollToTheLastOne.
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
	
	self layoutPolicy: (GLMBrickHorizontalFillLinearLayout new).
		
	self band: self newBand.
	self height: [ self items isEmpty ifTrue: [ 0 ] ifFalse: [ self defaultBreadcrumbHeight ] ]
	
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

{ #category : #notifying }
GTSpotterStepsBreadcrumb >> notifyBreadcrumbVisibilityChanged [

	self announcer announce: GTSpotterBreadcrumbVisibilityChanged new
]

{ #category : #'events-processing' }
GTSpotterStepsBreadcrumb >> onStepAdded: ann [
	|step origin previousStep selectedCandidate|
	
	self spotterModel steps size <= 1 ifTrue: [ ^ self ].
	
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
	
	"optimization. if last item was popped we need to update root to reposition all brick,
	otherwise only I need to be updated"
	self items size = 0
		ifTrue: [ self notifyBreadcrumbVisibilityChanged ]
		ifFalse: [
			self items last showTriangle.
			self doLayout.
			self changed ]
]

{ #category : #'adding/removing' }
GTSpotterStepsBreadcrumb >> push: aBrick [
	self theme spotterWidgetThemer breadcrumbItemStyleFor: aBrick.
	
	aBrick width: [ :itemBrick | self calculateItemWidth: itemBrick ].
	
	self items isEmpty ifFalse: [ self items last hideTriangle ].
	self band addBrickBack: aBrick.
	self items addLast: aBrick.
	
	"optimization. if first item was added we need to update root to reposition all brick,
	otherwise only I need to be updated"
	self items size = 1
		ifTrue: [ self notifyBreadcrumbVisibilityChanged ]
		ifFalse: [
			self doLayout.
			self changed ].
	
]

{ #category : #geometry }
GTSpotterStepsBreadcrumb >> scrollToTheLastOne [
	|leftDelta rightDelta delta|
	self items isEmpty ifTrue: [ ^ self ].
	
	self band translateX: self band data.
	
	rightDelta := self globalBounds right - self band globalBounds right.
	leftDelta := self globalBounds left - self band globalBounds left.
			
	"all visible, return"
	(leftDelta = 0  and: [ self items size <= self maxNumberOfSteps ]) ifTrue: [ ^ self ].
	
	delta := (self items size <= self maxNumberOfSteps) ifTrue: [leftDelta] ifFalse: [rightDelta].
	self band data: (self band data + delta).

	"self band brickBounds: (self band brickBounds translateBy: delta@0)."
	
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
	
	spotterModel announcer subscribe: GTSpotterStepAdded send: #onStepAdded: to: self.
	spotterModel announcer subscribe: GTSpotterStepPopped send: #onStepPopped to: self.
]
