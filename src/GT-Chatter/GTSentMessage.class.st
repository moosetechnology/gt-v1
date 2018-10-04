Class {
	#name : #GTSentMessage,
	#superclass : #GTMessageHolder,
	#category : #'GT-Chatter-Model'
}

{ #category : #converting }
GTSentMessage >> asMorph [
	^ super asMorph
			color: Color lightBlue lighter;
			yourself 
]

{ #category : #printing }
GTSentMessage >> printOn: aStream [
	aStream nextPutAll: 'Sent: '.
	super printOn: aStream.
]

{ #category : #visitor }
GTSentMessage >> visit: aVisitor [
	aVisitor acceptSentMessage: self
]
