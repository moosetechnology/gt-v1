Class {
	#name : #GTOMe,
	#superclass : #GTOUser,
	#category : #'GT-Chatter-NewModel'
}

{ #category : #adding }
GTOMe >> addMessage: aGTOMessage [
	^ self chats add: aGTOMessage
]

{ #category : #adding }
GTOMe >> addMessage: aGTOMessage recipient: aGTOUserSign [ 
	^ self chats add: aGTOMessage recipient: aGTOUserSign 
]

{ #category : #accessing }
GTOMe >> chats [
	^ self 
		optionAt: #chats
		ifAbsentPut: [ GTOChats new ]
]

{ #category : #accessing }
GTOMe >> lastMessageWith: aGTOUser [ 
	^ self chats lastMessageWith: aGTOUser
]

{ #category : #printing }
GTOMe >> printOn: aStream [
	self nickname 
		ifNil: [ aStream nextPutAll: 'a user' ]
		ifNotNil: [ aStream print: self nickname ].
]
