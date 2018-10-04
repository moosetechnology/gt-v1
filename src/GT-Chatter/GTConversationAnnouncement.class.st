Class {
	#name : #GTConversationAnnouncement,
	#superclass : #GTInternalAnnouncement,
	#instVars : [
		'conversation'
	],
	#category : #'GT-Chatter-InternalAnnouncements'
}

{ #category : #accessing }
GTConversationAnnouncement >> conversation [
	^ conversation
]

{ #category : #accessing }
GTConversationAnnouncement >> conversation: anObject [
	conversation := anObject
]

{ #category : #accessing }
GTConversationAnnouncement >> recipient [
	^ self conversation recipient
]
