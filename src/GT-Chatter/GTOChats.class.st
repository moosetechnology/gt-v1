Class {
	#name : #GTOChats,
	#superclass : #Object,
	#instVars : [
		'chats'
	],
	#category : #'GT-Chatter-NewModel'
}

{ #category : #adding }
GTOChats >> add: aGTOTextMessage [ 
	^ self add: aGTOTextMessage recipient: aGTOTextMessage from
]

{ #category : #adding }
GTOChats >> add: aGTOTextMessage recipient: aGTOUser [
	^ self 
				detectChatWith: aGTOUser
				ifFound: [ :aChat | aChat add: aGTOTextMessage ]
				ifNone: [ | chat |
					chat := (self newChatWith: aGTOUser) add: aGTOTextMessage; yourself.
					self chats add: chat ].
]

{ #category : #accessing }
GTOChats >> chats [
	^ chats ifNil: [ chats := OrderedCollection new ]
]

{ #category : #enumerating }
GTOChats >> detectChatWith: aGTOUser ifFound: foundBlock ifNone: noneblock [ 
	^ self chats 
				detect: [ :eachChat | eachChat recipient = aGTOUser ]
				ifFound: foundBlock 
				ifNone: noneblock 
]

{ #category : #accessing }
GTOChats >> lastMessageFrom: aGTOUser [ 
	^ self  
			detectChatWith: aGTOUser 
			ifFound: [ :aChat | aChat lastMessage ] 
			ifNone: [ nil ]
]

{ #category : #'instance creation' }
GTOChats >> newChatWith: aGTOUser [ 
	^ GTOChat recipient: aGTOUser
]
