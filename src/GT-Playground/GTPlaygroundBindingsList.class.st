Class {
	#name : #GTPlaygroundBindingsList,
	#superclass : #GLMFallbackScrollListBrick,
	#category : #'GT-Playground'
}

{ #category : #'as yet unclassified' }
GTPlaygroundBindingsList >> initialize [
	super initialize.
	
	self
		emptyBrick: self newEmptyText;
		height: [ :b | b band height ];
		maxHeight: 300;
		width: 300
]

{ #category : #'instance creation' }
GTPlaygroundBindingsList >> newActionButton [
	|margin padding|
	margin := self themer bindingThemer padding + self themer bindingThemer borderWidth.
	padding := (margin / 2) rounded.
	
	^ GLMHintableActionButtonBrick new
		padding: padding;
		margin: {0 . padding};
		marginRight: margin;
		hShrinkWrap;
		pressedColor: self themer buttonPressedColor
]

{ #category : #'instance creation' }
GTPlaygroundBindingsList >> newBindingLabel [

	^ GLMLabelBrick new
		hSpaceFill: 50;
		vShrinkWrap;
		textPosition: #leftCenter;
		vAlign: #center;
		padding: { 0 . self themer bindingThemer padding }
]

{ #category : #'instance creation' }
GTPlaygroundBindingsList >> newBindingRow: anAssociation in: aCollection [

	^ self newRow
		borderWidth: { 0 . 0 . aCollection last == anAssociation ifTrue: [ 0 ] ifFalse: [ self themer bindingThemer borderWidth ] . 0 };
		addAllBricks: {
			self newBindingLabel
				textColor: self themer textLightColor;
				text: anAssociation key.
			self newBindingLabel
				text: anAssociation value asString.
			self newRemoveButtonFor: anAssociation };
		yourself
]

{ #category : #'instance creation' }
GTPlaygroundBindingsList >> newEmptyText [

	^ GLMLabelBrick new
			text: 'No bindings';
			hSpaceFill;
			textPosition: #center;
			padding: self themer bindingThemer emptyTextPadding;
			textColor: self themer bindingThemer emptyTextColor;
			fontSize: self themer bindingThemer emptyTextFontSize;
			yourself
]

{ #category : #'instance creation' }
GTPlaygroundBindingsList >> newRemoveButtonFor: anAssociation [

	^ self newActionButton
		hintTitle: 'Remove binding';
		hintText: 'will unassign variable';
		icon: self themer bindingThemer removeIcon;
		action: [ : b |
			b owner disable.
			GLMAnimation swipeLeft
				onCompleted: [
					self announce: #bindingRemoved event: anAssociation.
					self model origin remove: anAssociation.
					self invalidate ];
				animate: b owner ]
]

{ #category : #'instance creation' }
GTPlaygroundBindingsList >> newRow [

	^ GLMInteractableBrick new
		enable;
		selectedColor: self themer bindingThemer selectedColor;
		vShrinkWrap;
		hSpaceFill;
		padding: { self themer bindingThemer padding . 0 . self themer bindingThemer padding + self themer bindingThemer borderWidth };
		borderColor: self themer bindingThemer borderColor
]

{ #category : #'instance creation' }
GTPlaygroundBindingsList >> on: aBindingsCollection [
	|model|
	model := GLMBrickListModel new
		on: aBindingsCollection.
	model
		morphAtLogic: [ :index | self newBindingRow: (model origin at: index) in: model origin ].
	self model: model
]
