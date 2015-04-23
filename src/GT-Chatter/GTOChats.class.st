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
GTOChats >> add: aGTOTextMessage recipient: aGTOUserSign [
	^ self 
				detectChatWith: aGTOUserSign
				ifFound: [ :aChat | aChat add: aGTOTextMessage ]
				ifNone: [ | chat |
					chat := (self newChatWith: aGTOUserSign) add: aGTOTextMessage; yourself.
					self chats add: chat ].
]

{ #category : #accessing }
GTOChats >> chats [
	^ chats ifNil: [ chats := OrderedCollection new ]
]

{ #category : #enumerating }
GTOChats >> detectChatWith: aGTOUserSign ifFound: foundBlock ifNone: noneblock [ 
	^ self chats 
				detect: [ :eachChat | eachChat recipient = aGTOUserSign ]
				ifFound: foundBlock 
				ifNone: noneblock 
]

{ #category : #accessing }
GTOChats >> lastMessageWith: aGTOUser [ 
	^ self  
			detectChatWith: aGTOUser sign
			ifFound: [ :aChat | aChat lastMessage ] 
			ifNone: [ nil ]
]

{ #category : #'instance creation' }
GTOChats >> newChatWith: aGTOUserSign [ 
	^ GTOChat recipient: aGTOUserSign
]
