Class {
	#name : #GTConversationSelected,
	#superclass : #GTUIAnnouncement,
	#instVars : [
		'conversation'
	],
	#category : #'GT-Chatter-InternalAnnouncements'
}

{ #category : #accessing }
GTConversationSelected >> conversation [
	^ conversation
]

{ #category : #accessing }
GTConversationSelected >> conversation: aConversation [
	conversation := aConversation
]

{ #category : #visitor }
GTConversationSelected >> visit: aVisitor [
	^ aVisitor acceptConversationSelected: self
]
