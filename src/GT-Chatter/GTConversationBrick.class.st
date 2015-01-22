Class {
	#name : #GTConversationBrick,
	#superclass : #GLMBrick,
	#instVars : [
		'listAdaptor',
		'listBrick',
		'inputBrick',
		'onlineUsersBrick',
		'chatterModel'
	],
	#category : #'GT-Chatter-UI'
}

{ #category : #accessing }
GTConversationBrick >> chatterModel: aGTChatter [ 
	chatterModel := aGTChatter
]

{ #category : #accessing }
GTConversationBrick >> conversation: aConversation [
	self data: aConversation.
	self recipientBrickOn: aConversation.
	self listAdaptor on: aConversation messages.
	self invalidate.
	self inputBrick data: aConversation.
]

{ #category : #initialization }
GTConversationBrick >> initialize [
	super initialize.
	self layoutProperties hSpaceFill.
	self layoutPolicy: GLMBrickVerticalFillProportionalLinearLayout new.
]

{ #category : #accessing }
GTConversationBrick >> inputBrick [
	^ inputBrick ifNil: [ 
			inputBrick := self newInputBrick.
			inputBrick layoutProperties staticHeight: 30; hSpaceFill.
			self addBrickBack: inputBrick.
			inputBrick ]
]

{ #category : #scrolling }
GTConversationBrick >> invalidate [
	self listBrick invalidate.
	self brickRoot doLayout.
	self listBrick scrollToBottom.
	self brickRoot changed.
]

{ #category : #accessing }
GTConversationBrick >> listAdaptor [
	^ listAdaptor ifNil: [ 
		listAdaptor := GTRowBrickAdaptor new
								on: #();
								owner: self;
								modelAccessor: #setupBrick:message:
								yourself ]
]

{ #category : #accessing }
GTConversationBrick >> listBrick [
	^ listBrick ifNil: [ 
			listBrick := GLMFallbackScrollListBrick new adaptor: self listAdaptor; yourself.
			listBrick layoutProperties verticalPercent: 100.
			self addBrickBack: listBrick.
			listBrick ]
]

{ #category : #'events-processing' }
GTConversationBrick >> messageAdded: aGTMessageAdded [ 
	self invalidate
]

{ #category : #'instance creation' }
GTConversationBrick >> newInputBrick [
	^ GTMessageInputFieldBrick new
]

{ #category : #'instance creation' }
GTConversationBrick >> newMessageRowBrick [
	^ self newRowBrick
]

{ #category : #'instance creation' }
GTConversationBrick >> newOnlineUsersDropListBrick [
	^ GTOnlineUsersDropListBrick new.
]

{ #category : #'instance creation' }
GTConversationBrick >> newRowBrick [
	^ GTMessageRowBrick new.
]

{ #category : #accessing }
GTConversationBrick >> onlineRecipientBrickOn: aConversation [
	"add drop down list with online users"
	self onlineUsersBrick: self newOnlineUsersDropListBrick.
	self onlineUsersBrick conversation: aConversation.
	
]

{ #category : #accessing }
GTConversationBrick >> onlineUsersBrick [
	^ onlineUsersBrick
]

{ #category : #accessing }
GTConversationBrick >> onlineUsersBrick: aBrick [
	self onlineUsersBrick ifNotNil: [ :anOldBrick | self removeBrick: anOldBrick ].
	onlineUsersBrick := aBrick.
	onlineUsersBrick chatterModel: chatterModel.
	onlineUsersBrick 
		layoutProperties staticHeight: 30; hSpaceFill.
	self addBrick: aBrick before: self listBrick.
	self doLayout; changed.
]

{ #category : #accessing }
GTConversationBrick >> recipientBrickOn: aConversation [
	aConversation isNewConversation 
		ifTrue: [ self onlineRecipientBrickOn: aConversation ]
]

{ #category : #protocol }
GTConversationBrick >> setupBrick: aGTMessageRowBrickOrNil message: aGTMessage [ 
	^ aGTMessage updateBrick: aGTMessageRowBrickOrNil factory: self
]
