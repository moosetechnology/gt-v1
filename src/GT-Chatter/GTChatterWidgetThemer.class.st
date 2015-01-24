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

{ #category : #styles }
GTChatterWidgetThemer >> chatterStyleFor: aBrick [

]

{ #category : #accessing }
GTChatterWidgetThemer >> conversationHorizontalPercent [
	^ 70
]

{ #category : #'styles - conversations' }
GTChatterWidgetThemer >> conversationRowStyleFor: aBrick [
	aBrick
		"to allow my children have proportional width (i.e 33% of me) and to fill my height"	
		layoutPolicy: GLMBrickHorizontalFillProportionalLinearLayout new;
		enable;
		normalColor: Color lightGray lighter;
		selectedColor: Color lightGray;
		pressedColor: Color gray;
		checkedColor: Color gray.
		
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

{ #category : #'styles - conversations' }
GTChatterWidgetThemer >> createConversationButtonStyleFor: aBrick [
	aBrick 
		normalImage: GLMUIThemeExtraIcons glamorousAdd;
		pressedColor: Color darkGray; 
		selectedColor: Color gray;
		enabled.
	aBrick layoutProperties 
		staticWidth: 30;
		staticHeight: 30.
]

{ #category : #'styles - messages' }
GTChatterWidgetThemer >> messageCommonStyleFor: aBrick [
	aBrick layoutProperties 
		horizontalPercent: 95;
		vShrinkWrap.
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

{ #category : #'styles - conversation' }
GTChatterWidgetThemer >> onlineUsersStyleFor: aBrick [
	aBrick layoutProperties 
		staticHeight: 30; 
		hSpaceFill.
]

{ #category : #'styles - source code pointer' }
GTChatterWidgetThemer >> receivedSourceCodeLabelStyleFor: aBrick [
	aBrick textColor: Color white.
]

{ #category : #'styles - source code pointer' }
GTChatterWidgetThemer >> receivedSourceCodePointerStyleFor: aBrick [
	aBrick color: Color green muchDarker
]

{ #category : #'styles - text message' }
GTChatterWidgetThemer >> receivedTextMessageEditingAreaStyleFor: aBrick [
	aBrick
		backgroundColor: Color lightGray;
		textColor: Color black.
]

{ #category : #'styles - conversations' }
GTChatterWidgetThemer >> recipientStyleFor: aBrick [
	aBrick textPosition: #center.
	aBrick layoutProperties horizontalPercent: 100.
]

{ #category : #'styles - source code pointer' }
GTChatterWidgetThemer >> sentSourceCodePointerStyleFor: aBrick [
	aBrick color: Color lightGray
]

{ #category : #'styles - text message' }
GTChatterWidgetThemer >> sentTextMessageEditingAreaStyleFor: aBrick [
	aBrick
		backgroundColor: Color green muchDarker;
		textColor: Color white.
]

{ #category : #'styles - source code pointer' }
GTChatterWidgetThemer >> sourceCodePointerBrowseButtonStyleFor: aBrick [
	aBrick
		enable;
		icon: GLMUIThemeExtraIcons glamorousBrowse.
	aBrick layoutProperties 
		horizontalPercent: 0;
		staticWidth: [ :brick | brick normalImage width ].
]

{ #category : #'styles - source code pointer' }
GTChatterWidgetThemer >> sourceCodePointerLabelStyleFor: aBrick [
	aBrick layoutProperties hSpaceFill.
]

{ #category : #'styles - source code pointer' }
GTChatterWidgetThemer >> sourceCodePointerStyleFor: aBrick [
	self messageCommonStyleFor: aBrick.
	aBrick layoutProperties
		paddingLeft: 5;
		paddingRight: 5;
		paddingTop: 0;
		paddingBottom: 0
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
GTChatterWidgetThemer >> textMessageEditorStyleFor: aBrick [
	aBrick layoutProperties 
		staticHeight: 30; 
		hSpaceFill.

]

{ #category : #'styles - text message' }
GTChatterWidgetThemer >> textMessageStyleFor: aBrick [
	self messageCommonStyleFor: aBrick.
]
