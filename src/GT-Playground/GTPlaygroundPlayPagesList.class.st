Class {
	#name : #GTPlaygroundPlayPagesList,
	#superclass : #GLMFallbackScrollListBrick,
	#category : #'GT-Playground'
}

{ #category : #initialization }
GTPlaygroundPlayPagesList >> initialize [
	super initialize.
	
	self
		emptyBrick: self newEmptyText;
		maxHeight: 350;
		height: [ :b | b band height ];
		width: 250
]

{ #category : #'instance creation' }
GTPlaygroundPlayPagesList >> newEmptyText [

	^ GLMLabelBrick new
			text: 'No saved pages';
			hSpaceFill;
			textPosition: #center;
			padding: self themer bindingThemer emptyTextPadding;
			textColor: self themer bindingThemer emptyTextColor;
			fontSize: self themer bindingThemer emptyTextFontSize;
			yourself
]

{ #category : #'instance creation' }
GTPlaygroundPlayPagesList >> newPageLabel [

	^ GLMLabelBrick new
		enable;
		hSpaceFill;
		vShrinkWrap;
		textPosition: #leftCenter;
		vAlign: #center;
		padding: { 0 . self themer bindingThemer padding }
]

{ #category : #'instance creation' }
GTPlaygroundPlayPagesList >> newPageRow: playPage in: aGTPlayBook [

	^ self newPageLabel
		textColor: self themer textColor;
		text: (playPage content asString contractTo: 50);
		selectedColor: self themer bindingThemer selectedColor;
		padding: self themer bindingThemer padding;
		when: #onClicked do: [ self remove. self announce: #pageAccepted event: playPage ];
		yourself
]

{ #category : #'instance creation' }
GTPlaygroundPlayPagesList >> on: aGTPlayBook [
	|model|
	model := GLMBrickListModel new
		on: aGTPlayBook pages.
	model
		morphAtLogic: [ :index | self newPageRow: (model origin at: index) in: aGTPlayBook ].
	self model: model
]

{ #category : #'brick-properties-events' }
GTPlaygroundPlayPagesList >> onThemerChanged [
	super onThemerChanged.
	
	self doLayoutForce
]

{ #category : #actions }
GTPlaygroundPlayPagesList >> remove [

	(self ownerThatIsA:  GLMFoundationBrick)
		ifNotNil: [ :o | o delete ]
]
