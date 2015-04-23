Class {
	#name : #GTOTextMessage,
	#superclass : #GTOAddressedMessage,
	#instVars : [
		'text'
	],
	#category : #'GT-Chatter-NewModel'
}

{ #category : #accessing }
GTOTextMessage >> text [
	^ text
]

{ #category : #accessing }
GTOTextMessage >> text: anObject [
	text := anObject
]
