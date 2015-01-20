Class {
	#name : #GTCTextMessage,
	#superclass : #GTCAddressedMessage,
	#instVars : [
		'message'
	],
	#category : #'GT-Chatter-RemoteAnnouncements'
}

{ #category : #'instance creation' }
GTCTextMessage class >> to: to [

	^ self new
		to: to;
		yourself
]

{ #category : #converting }
GTCTextMessage >> asMessageMorph [
	^ GTCTextMessageBrick new
			message: self;
			yourself
]

{ #category : #accessing }
GTCTextMessage >> message [
	^ message
]

{ #category : #accessing }
GTCTextMessage >> message: anObject [
	message := anObject
]

{ #category : #printing }
GTCTextMessage >> printOn: aStream [
	aStream print: self message
]
