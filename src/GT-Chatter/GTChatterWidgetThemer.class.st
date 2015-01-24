Class {
	#name : #GTChatterWidgetThemer,
	#superclass : #Object,
	#classInstVars : [
		'instance'
	],
	#category : #'GT-Chatter-Theme'
}

{ #category : #accessing }
GTChatterWidgetThemer class >> reset [
	instance := nil
]

{ #category : #'instance creation' }
GTChatterWidgetThemer class >> uniqueInstance [ 
	^ instance ifNil: [ instance := self new ]
]

{ #category : #values }
GTChatterWidgetThemer >> backgroundColor [
	"used as background color for all panes"
	^ Color white
]

{ #category : #values }
GTChatterWidgetThemer >> borderColor [
	"color that is used for border and dividers of UI parts of Spotter
	for example divider between header and results or between preview and list"
	^ Color r: 180 g: 180 b: 180 range: 255
]

{ #category : #values }
GTChatterWidgetThemer >> buttonPressedColor [

	^ self backgroundColor darker
]

{ #category : #values }
GTChatterWidgetThemer >> buttonSelectedColor [
	^ self buttonPressedColor darker
]

{ #category : #styles }
GTChatterWidgetThemer >> chatterStyleFor: aBrick [
	aBrick
		color: self backgroundColor
]

{ #category : #values }
GTChatterWidgetThemer >> conversationHorizontalPercent [
	^ 70
]

{ #category : #'styles - conversations' }
GTChatterWidgetThemer >> conversationRowStyleFor: aBrick [
	aBrick
		"to allow my children have proportional width (i.e 33% of me) and to fill my height"	
		layoutPolicy: GLMBrickHorizontalFillProportionalLinearLayout new;
		enable;
		normalColor: self itemNormalBackgroundColor;
		selectedColor: self itemSelectedBackgroundColor;
		pressedColor: self itemPressedBackgroundColor;
		checkedColor: self itemCheckedBackroundColor.
		
	"here we configurate paddings"
	aBrick layoutProperties
		hSpaceFill;
		paddingLeft: 5;
		paddingRight: 5;
		paddingTop: 10;
		paddingBottom: 10.
]

{ #category : #'styles - conversation' }
GTChatterWidgetThemer >> conversationStyleFor: aBrick [
	aBrick layoutPolicy: GLMBrickVerticalFillProportionalLinearLayout new.
	aBrick layoutProperties 
		vSpaceFill; 
		horizontalPercent: self conversationHorizontalPercent.
]

{ #category : #styles }
GTChatterWidgetThemer >> conversationsAndMessagesStyleFor: aBrick [
	aBrick layoutPolicy: GLMBrickHorizontalFillProportionalLinearLayout new.
	aBrick layoutProperties 
		vSpaceFill; 
		hSpaceFill.

]

{ #category : #'styles - conversations' }
GTChatterWidgetThemer >> conversationsScrollListStyleFor: aBrick [
	aBrick layoutProperties 
		hSpaceFill; 
		verticalPercent: 100.
]

{ #category : #'styles - conversations' }
GTChatterWidgetThemer >> conversationsStyleFor: aBrick [
	aBrick layoutPolicy: GLMBrickVerticalFillProportionalLinearLayout new.
	aBrick layoutProperties 
		vSpaceFill; 
		horizontalPercent: 100 - self conversationHorizontalPercent.

]

{ #category : #icons }
GTChatterWidgetThemer >> createConversationButtonIcon [
	^ GLMUIThemeExtraIcons glamorousAdd
]

{ #category : #'styles - conversations' }
GTChatterWidgetThemer >> createConversationButtonStyleFor: aBrick [
	aBrick 
		normalImage: self createConversationButtonIcon;
		pressedColor: self buttonPressedColor ; 
		selectedColor: self buttonSelectedColor;
		enabled.
	aBrick layoutProperties 
		staticWidth: 30;
		staticHeight: 30.
]

{ #category : #'styles - conversation' }
GTChatterWidgetThemer >> dropListStyleFor: aBrick [
	aBrick
		layoutProperties: GLMBrickLayoutProperties new;
		ghostText: self onlineUserGhostText.
	aBrick layoutProperties 
		vSpaceFill; 
		hSpaceFill.

]

{ #category : #values }
GTChatterWidgetThemer >> editorGhostText [
	^ 'Write new message here'
]

{ #category : #values }
GTChatterWidgetThemer >> itemCheckedBackroundColor [
	^ self itemPressedBackgroundColor
]

{ #category : #values }
GTChatterWidgetThemer >> itemNormalBackgroundColor [
	^ Color transparent
]

{ #category : #values }
GTChatterWidgetThemer >> itemPressedBackgroundColor [
	^ self itemSelectedBackgroundColor darker
]

{ #category : #values }
GTChatterWidgetThemer >> itemSelectedBackgroundColor [
	^ self backgroundColor darker
]

{ #category : #'styles - message' }
GTChatterWidgetThemer >> messageCommonStyleFor: aBrick [
	aBrick
		shadowWidth: 5.
	aBrick layoutProperties 
		horizontalPercent: 95;
		vShrinkWrap;
		paddingLeft: 5;
		paddingRight: 5;
		paddingTop: 5;
		paddingBottom: 5
]

{ #category : #'styles - conversation' }
GTChatterWidgetThemer >> messageRowStyleFor: aBrick [
	aBrick
		"to allow my children have proportional width (i.e 33% of me) and to fill my height"	
		layoutPolicy: GLMBrickHorizontalFillProportionalLinearLayout new.
		
	"here we configurate paddings"
	aBrick layoutProperties
		hSpaceFill;
		vShrinkWrap;
		paddingLeft: 5;
		paddingRight: 5;
		paddingTop: 5;
		paddingBottom: 5
]

{ #category : #'styles - conversation' }
GTChatterWidgetThemer >> messagesScrollListStyleFor: aBrick [
	aBrick layoutProperties 
		verticalPercent: 100.

]

{ #category : #values }
GTChatterWidgetThemer >> onlineUserGhostText [
	^ 'Select an online user'
]

{ #category : #'styles - conversation' }
GTChatterWidgetThemer >> onlineUsersStyleFor: aBrick [
	aBrick layoutProperties 
		staticHeight: 30; 
		hSpaceFill.
]

{ #category : #values }
GTChatterWidgetThemer >> outerBorderWidth [
	"the width of the border around the whole spotter"
	^ 5
]

{ #category : #'values - message' }
GTChatterWidgetThemer >> receivedMessageBackgroundColor [
	^ self itemSelectedBackgroundColor darker
]

{ #category : #'styles - message' }
GTChatterWidgetThemer >> receivedMessageCommonStyleFor: aBrick [
	aBrick
		shadowColor: self shadowColor.
]

{ #category : #'values - message' }
GTChatterWidgetThemer >> receivedMessageTextColor [
	^ self textColor
]

{ #category : #'styles - source code pointer' }
GTChatterWidgetThemer >> receivedSourceCodePointerLabelStyleFor: aBrick [
	aBrick textColor: self receivedMessageTextColor.
]

{ #category : #'styles - source code pointer' }
GTChatterWidgetThemer >> receivedSourceCodePointerStyleFor: aBrick [
	self receivedMessageCommonStyleFor: aBrick.
	aBrick color: self receivedMessageBackgroundColor
]

{ #category : #'styles - text message' }
GTChatterWidgetThemer >> receivedTextMessageEditingAreaStyleFor: aBrick [
	aBrick
		backgroundColor: self receivedMessageBackgroundColor;
		textColor: self receivedMessageTextColor.
]

{ #category : #'styles - text message' }
GTChatterWidgetThemer >> receivedTextMessageStyleFor: aBrick [
	self receivedMessageCommonStyleFor: aBrick.
]

{ #category : #'styles - conversations' }
GTChatterWidgetThemer >> recipientStyleFor: aBrick [
	aBrick textPosition: #center.
	aBrick layoutProperties horizontalPercent: 100.
]

{ #category : #'styles - conversation' }
GTChatterWidgetThemer >> scrolledTextMorphStyleFor: aBrick [
	aBrick
		layoutProperties: GLMBrickLayoutProperties new;
		beWrapped;
		withoutAdornment;
		withGhostText: self editorGhostText;
		alwaysAccept: true;
		autoAccept: false.
	aBrick layoutProperties 
		vSpaceFill; 
		hSpaceFill.

]

{ #category : #'values - message' }
GTChatterWidgetThemer >> sentMessageBackgroundColor [
	^ self itemSelectedBackgroundColor
]

{ #category : #'styles - message' }
GTChatterWidgetThemer >> sentMessageCommonStyleFor: aBrick [
	aBrick
		shadowColor: self shadowColor.
]

{ #category : #'values - message' }
GTChatterWidgetThemer >> sentMessageTextColor [
	^ self textColor
]

{ #category : #'styles - source code pointer' }
GTChatterWidgetThemer >> sentSourceCodePointerLabelStyleFor: aBrick [
	aBrick textColor: self sentMessageTextColor.
]

{ #category : #'styles - source code pointer' }
GTChatterWidgetThemer >> sentSourceCodePointerStyleFor: aBrick [
	self sentMessageCommonStyleFor: aBrick.
	aBrick color: self sentMessageBackgroundColor
]

{ #category : #'styles - text message' }
GTChatterWidgetThemer >> sentTextMessageEditingAreaStyleFor: aBrick [
	aBrick
		backgroundColor: self sentMessageBackgroundColor;
		textColor: self sentMessageTextColor.
]

{ #category : #'styles - text message' }
GTChatterWidgetThemer >> sentTextMessageStyleFor: aBrick [
	self sentMessageCommonStyleFor: aBrick.
]

{ #category : #values }
GTChatterWidgetThemer >> shadowColor [
	^ self backgroundColor darker alpha: 0.2
]

{ #category : #'styles - source code pointer' }
GTChatterWidgetThemer >> sourceCodePointerBrowseButtonStyleFor: aBrick [
	aBrick
		enable;
		icon: GLMUIThemeExtraIcons glamorousBrowse.
	aBrick layoutProperties 
		horizontalPercent: 0;
		staticWidth: [ :brick | brick normalImage width + (2 * self outerBorderWidth) ].
]

{ #category : #'styles - source code pointer' }
GTChatterWidgetThemer >> sourceCodePointerLabelStyleFor: aBrick [
	aBrick padding: #(5 5).
	aBrick layoutProperties hSpaceFill.
]

{ #category : #'styles - source code pointer' }
GTChatterWidgetThemer >> sourceCodePointerStyleFor: aBrick [
	self messageCommonStyleFor: aBrick.

]

{ #category : #values }
GTChatterWidgetThemer >> textColor [
	^ Color black
]

{ #category : #'styles - text message' }
GTChatterWidgetThemer >> textMessageEditingAreaStyleFor: aBrick [
	aBrick
		layoutProperties: GLMBrickLayoutProperties new;
		beReadOnly;
		beWrapped.
	aBrick layoutProperties 
		hSpaceFill.
]

{ #category : #'styles - conversation' }
GTChatterWidgetThemer >> textMessageInputFieldStyleFor: aBrick [
	aBrick
		height: [ :brick | brick totalTextHeight ].
	aBrick layoutProperties 
		staticHeight: [ :brick | brick totalTextHeight ];
		hSpaceFill.

]

{ #category : #'styles - text message' }
GTChatterWidgetThemer >> textMessageStyleFor: aBrick [
	self messageCommonStyleFor: aBrick.
]
