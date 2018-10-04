Class {
	#name : #GTOnlineUsersDropListBrick,
	#superclass : #GLMBrick,
	#instVars : [
		'dropList',
		'chatterModel'
	],
	#category : #'GT-Chatter-UI'
}

{ #category : #accessing }
GTOnlineUsersDropListBrick >> chatterModel [
	^ chatterModel
]

{ #category : #accessing }
GTOnlineUsersDropListBrick >> chatterModel: aGTChatter [ 
	chatterModel := aGTChatter.
	self dropList: self newDropList.
]

{ #category : #accessing }
GTOnlineUsersDropListBrick >> conversation [
	^ self data
]

{ #category : #accessing }
GTOnlineUsersDropListBrick >> conversation: aConversation [
	self data: aConversation.
]

{ #category : #accessing }
GTOnlineUsersDropListBrick >> dropList [
	^ dropList
]

{ #category : #accessing }
GTOnlineUsersDropListBrick >> dropList: aBrick [
	self dropList ifNotNil: [ :anOldBrick | self removeBrick: anOldBrick ].
	dropList := aBrick.
	self theme chatterWidgetThemer dropListStyleFor: dropList.
	dropList 
		on: self
			list: #recentOnlineUsers
			selected: nil
			changeSelected: #selectedRecipient:;
		useSelectionIndex: false.
	self addBrickBack: dropList.
]

{ #category : #'as yet unclassified' }
GTOnlineUsersDropListBrick >> initialize [
	super initialize.
	self theme chatterWidgetThemer onlineUsersStyleFor: self
]

{ #category : #'instance creation' }
GTOnlineUsersDropListBrick >> newDropList [
	^ DropListMorph new
]

{ #category : #accessing }
GTOnlineUsersDropListBrick >> onlineUsers [
	^ self chatterModel onlineUsers.
]

{ #category : #accessing }
GTOnlineUsersDropListBrick >> recentOnlineUsers [
	^ self onlineUsers recent
]

{ #category : #'events-processing' }
GTOnlineUsersDropListBrick >> selectedRecipient: aClientId [ 
	self conversation ifNotNil: [ :aConversation | aConversation recipient: aClientId ]
]
