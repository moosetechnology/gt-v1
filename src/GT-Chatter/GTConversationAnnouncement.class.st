Class {
	#name : #GTConversationAnnouncement,
	#superclass : #GTAnnouncement,
	#instVars : [
		'conversation'
	],
	#category : #'GT-Chatter-Announcements'
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
