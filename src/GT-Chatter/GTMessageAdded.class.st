Class {
	#name : #GTMessageAdded,
	#superclass : #GTConversationAnnouncement,
	#instVars : [
		'message'
	],
	#category : #'GT-Chatter-InternalAnnouncements'
}

{ #category : #accessing }
GTMessageAdded >> message [
	^ message
]

{ #category : #accessing }
GTMessageAdded >> message: anObject [
	message := anObject
]

{ #category : #visitor }
GTMessageAdded >> visit: aVisitor [
	^ aVisitor acceptMessageAdded: self
]
