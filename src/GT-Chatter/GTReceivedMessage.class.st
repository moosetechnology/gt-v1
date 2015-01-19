Class {
	#name : #GTReceivedMessage,
	#superclass : #GTMessageHolder,
	#category : #'GT-Chatter-Model'
}

{ #category : #converting }
GTReceivedMessage >> asMorph [
	^ super asMorph
			color: Color lightGreen lighter;
			yourself 
]

{ #category : #printing }
GTReceivedMessage >> printOn: aStream [
	aStream nextPutAll: 'Received: '.
	super printOn: aStream.
]

{ #category : #visitor }
GTReceivedMessage >> visit: aVisitor [
	aVisitor acceptReceivedMessage: self
]
