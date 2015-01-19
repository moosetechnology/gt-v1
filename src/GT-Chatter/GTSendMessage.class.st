Class {
	#name : #GTSendMessage,
	#superclass : #GTUIAnnouncement,
	#instVars : [
		'conversation'
	],
	#category : #'GT-Chatter-Announcements'
}

{ #category : #accessing }
GTSendMessage >> clientId [
	^ conversation recipient
]

{ #category : #accessing }
GTSendMessage >> conversation: aGTConversation [ 
	conversation := aGTConversation
]

{ #category : #accessing }
GTSendMessage >> message [
	^ self widget text copy
]

{ #category : #protocol }
GTSendMessage >> messageSent [
	"Clean input field."
	"self widget text: ''"
]
