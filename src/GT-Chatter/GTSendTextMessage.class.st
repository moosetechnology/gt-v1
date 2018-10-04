Class {
	#name : #GTSendTextMessage,
	#superclass : #GTUIAnnouncement,
	#instVars : [
		'conversation'
	],
	#category : #'GT-Chatter-InternalAnnouncements'
}

{ #category : #accessing }
GTSendTextMessage >> client [
	^ conversation recipient
]

{ #category : #obsolete }
GTSendTextMessage >> clientId [
	^ conversation recipient
]

{ #category : #accessing }
GTSendTextMessage >> conversation: aGTConversation [ 
	conversation := aGTConversation
]

{ #category : #accessing }
GTSendTextMessage >> message [
	^ self widget text copy
]

{ #category : #protocol }
GTSendTextMessage >> messageSent [
	"Clean input field."
	"self widget text: ''"
]
