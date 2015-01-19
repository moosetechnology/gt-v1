Class {
	#name : #GTInternetMessage,
	#superclass : #GTRemoteAnnouncement,
	#instVars : [
		'message'
	],
	#category : #'GT-Chatter-Announcements'
}

{ #category : #'instance creation' }
GTInternetMessage class >> message: message [

	^ self new
		message: message;
		yourself
]

{ #category : #accessing }
GTInternetMessage >> message [
	^ message
]

{ #category : #accessing }
GTInternetMessage >> message: anObject [
	
	message := anObject
]
