Class {
	#name : #GTOChat,
	#superclass : #Object,
	#instVars : [
		'recipient',
		'messages'
	],
	#category : #'GT-Chatter-NewModel'
}

{ #category : #'as yet unclassified' }
GTOChat class >> recipient: aGTOUser [ 
	^ self new recipient: aGTOUser; yourself
]

{ #category : #adding }
GTOChat >> add: aGTOMessage [ 
	^ self messages add: aGTOMessage 
]

{ #category : #accessing }
GTOChat >> lastMessage [
	^ self messages last
]

{ #category : #accessing }
GTOChat >> messages [
	^ messages ifNil: [ messages := OrderedCollection new ]
]

{ #category : #accessing }
GTOChat >> messages: anObject [
	messages := anObject
]

{ #category : #printing }
GTOChat >> printOn: aStream [
	aStream
		nextPutAll: 'Chat with ';
		print: self recipient.
]

{ #category : #accessing }
GTOChat >> recipient [
	^ recipient
]

{ #category : #accessing }
GTOChat >> recipient: aGTOUser [ 
	recipient := aGTOUser
]
