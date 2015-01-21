Class {
	#name : #GTConversationsBrick,
	#superclass : #GLMBrick,
	#instVars : [
		'listAdaptor',
		'listBrick',
		'lastCheckedRowBrick',
		'lastSelectedConversation',
		'conversationButton',
		'selectedConversationProcessor'
	],
	#category : #'GT-Chatter-UI'
}

{ #category : #accessing }
GTConversationsBrick >> chatterModel: aGTChatter [ 
	self data ifNotNil: [ self unsubscribeFromConversations ].
	self data: aGTChatter.
	self subscribeOnConversations.
	self listAdaptor on: self conversations.
	self listBrick invalidate.
]

{ #category : #'events-processing' }
GTConversationsBrick >> conversationAdded: aGTConversationAdded [
	self listBrick invalidate.
]

{ #category : #'events-processing' }
GTConversationsBrick >> conversationSelected: aGTConversationSelected [
	lastSelectedConversation = aGTConversationSelected conversation ifTrue: [ ^ self ].
	lastCheckedRowBrick ifNotNil: [ :brick | brick uncheck ].
	lastCheckedRowBrick := aGTConversationSelected widget.
	lastSelectedConversation := aGTConversationSelected conversation.
	aGTConversationSelected widget check.
	self passEvent: aGTConversationSelected.
	self brickRoot doLayout.
	self brickRoot changed
]

{ #category : #accessing }
GTConversationsBrick >> conversations [
	^ self data conversations
]

{ #category : #accessing }
GTConversationsBrick >> createConversationButtonBrick: aBrick [
	conversationButton ifNotNil: [ :anOldBrick | self removeBrick: anOldBrick ].
	conversationButton := aBrick.
	conversationButton
		normalImage: GLMUIThemeExtraIcons glamorousAdd;
		addUpAction: [ self createNewConversation ];
		pressedColor: Color darkGray; 
		selectedColor: Color gray;
		enabled.
	conversationButton layoutProperties 
		staticWidth: 30;
		staticHeight: 30.
	self addBrickBack: conversationButton.
]

{ #category : #private }
GTConversationsBrick >> createNewConversation [
	^ self conversations addNewConversation
]

{ #category : #initialization }
GTConversationsBrick >> initialize [
	super initialize.
	self layoutProperties vSpaceFill; hSpaceFill.
	self layoutPolicy: GLMBrickVerticalFillProportionalLinearLayout new.
	self createConversationButtonBrick: self newCreateConversationButtonBrick.
]

{ #category : #accessing }
GTConversationsBrick >> listAdaptor [
	^ listAdaptor ifNil: [ 
		listAdaptor := GTRowBrickAdaptor new
								on: #();
								owner: self;
								modelAccessor: #setupBrick:conversation:
								yourself ]
]

{ #category : #accessing }
GTConversationsBrick >> listBrick [
	^ listBrick ifNil: [ 
			listBrick := GLMFallbackScrollListBrick new adaptor: self listAdaptor; yourself.
			listBrick layoutProperties hSpaceFill; verticalPercent: 100.
			self addBrickBack: listBrick.
			listBrick ]
]

{ #category : #'events-processing' }
GTConversationsBrick >> messageAdded: aGTMessageAdded [
	lastCheckedRowBrick ifNotNil: [ :aBrick |
		aBrick conversation = aGTMessageAdded conversation 
			ifTrue: [ self passEvent: aGTMessageAdded ] ]
]

{ #category : #'instance creation' }
GTConversationsBrick >> newCreateConversationButtonBrick [
	^ GLMActionButtonBrick new
]

{ #category : #'instance creation' }
GTConversationsBrick >> newRowBrick [
	| brick |
	brick := GTConversationRowBrick new.
	brick announcer weak 
		subscribe: GTConversationSelected 
		send: #conversationSelected: to: self.
	^ brick
]

{ #category : #'events-processing' }
GTConversationsBrick >> passEvent: aGTAnnouncement [ 
	selectedConversationProcessor 
		ifNotNil: [ :aProcessor | aGTAnnouncement visit: aProcessor ]
		ifNil: [ 	self doLayout; changed. ]
]

{ #category : #'events-processing' }
GTConversationsBrick >> passSelectedConversation: aGTConversationSelected [ 
	selectedConversationProcessor 
		ifNotNil: [ :aProcessor | aProcessor conversationSelected: aGTConversationSelected ]
		ifNil: [ 	self doLayout; changed. ]
]

{ #category : #accessing }
GTConversationsBrick >> selectedConversationProcessor: aBrick [
	selectedConversationProcessor := aBrick
]

{ #category : #initialization }
GTConversationsBrick >> setupBrick: aGTConversationRowBrickOrNil conversation: aGTConversation [ 
	| aBrick |
	aBrick := aGTConversation updateBrick: aGTConversationRowBrickOrNil factory: self.
	
	lastSelectedConversation = aGTConversation 
		ifTrue: [ 
			lastCheckedRowBrick := aBrick. 
			aBrick check ]
		ifFalse: [ aBrick uncheck ].
	^ aBrick


]

{ #category : #private }
GTConversationsBrick >> subscribeOnConversations [
	self conversations announcer
				subscribe: GTConversationAdded send: #conversationAdded: to: self;
				subscribe: GTMessageAdded send: #messageAdded: to: self.
]

{ #category : #private }
GTConversationsBrick >> unsubscribeFromConversations [
	self conversations announcer unsubscribe: self
]
