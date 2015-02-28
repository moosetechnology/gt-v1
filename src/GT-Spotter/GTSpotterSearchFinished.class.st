Class {
	#name : #GTSpotterSearchFinished,
	#superclass : #Announcement,
	#instVars : [
		'query'
	],
	#category : #'GT-Spotter-Announcements'
}

{ #category : #accessing }
GTSpotterSearchFinished >> query [
	^ query
]

{ #category : #accessing }
GTSpotterSearchFinished >> query: anObject [
	query := anObject
]
