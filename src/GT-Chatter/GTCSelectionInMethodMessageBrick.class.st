Class {
	#name : #GTCSelectionInMethodMessageBrick,
	#superclass : #GLMBrick,
	#instVars : [
		'labelBrick',
		'browseBrick'
	],
	#category : #'GT-Chatter-UI'
}

{ #category : #visitor }
GTCSelectionInMethodMessageBrick >> acceptReceivedMessage: aGTReceivedMessage [ 
	self color: Color lightGray
]

{ #category : #visitor }
GTCSelectionInMethodMessageBrick >> acceptSentMessage: aGTSentMessage [ 
	self color: Color green muchDarker.
	self labelBrick textColor: Color white.
]

{ #category : #accessing }
GTCSelectionInMethodMessageBrick >> browseBrick: aBrick [
	browseBrick ifNotNil: [ :anOldBrick | self removeBrick: anOldBrick ].
	browseBrick := aBrick.
	browseBrick 
		enable;
		addUpAction: [ self browseMethod ];
		icon: GLMUIThemeExtraIcons glamorousBrowse.
	browseBrick layoutProperties 
		horizontalPercent: 0;
		staticWidth: [ :brick | brick normalImage width ].
	self addBrickBack: aBrick.
]

{ #category : #protocol }
GTCSelectionInMethodMessageBrick >> browseMethod [
	^ self message ifNotNil: [ :aMessage | aMessage ring browse ]
]

{ #category : #initialization }
GTCSelectionInMethodMessageBrick >> initialize [
	super initialize.
	self layoutProperties hSpaceFill.
	self layoutPolicy: GLMBrickHorizontalProportionalLinearLayout new.
	
	self labelBrick: self newLabelBrick.
	self browseBrick: self newBrowseBrick.

	"here we configurate paddings"
	self layoutProperties
		hSpaceFill;
		vShrinkWrap;
		paddingLeft: 5;
		paddingRight: 5;
		paddingTop: 0;
		paddingBottom: 0
]

{ #category : #accessing }
GTCSelectionInMethodMessageBrick >> labelBrick [
	^ labelBrick
]

{ #category : #accessing }
GTCSelectionInMethodMessageBrick >> labelBrick: aBrick [
	labelBrick ifNotNil: [ :anOldBrick | self removeBrick: anOldBrick ].
	labelBrick := aBrick.
	labelBrick layoutProperties hSpaceFill.
	self addBrickBack: aBrick.
]

{ #category : #accessing }
GTCSelectionInMethodMessageBrick >> message [
	^ self data
]

{ #category : #accessing }
GTCSelectionInMethodMessageBrick >> message: aSelectionInMethodMessage [
	self message = aSelectionInMethodMessage ifTrue: [ ^ self ].
	self data: aSelectionInMethodMessage.
	self labelBrick text: aSelectionInMethodMessage ring asString.
	self changed.
]

{ #category : #'instance creation' }
GTCSelectionInMethodMessageBrick >> newBrowseBrick [
	^ GLMActionButtonBrick new
]

{ #category : #'instance creation' }
GTCSelectionInMethodMessageBrick >> newLabelBrick [
	^ GLMLabelBrick new
]
