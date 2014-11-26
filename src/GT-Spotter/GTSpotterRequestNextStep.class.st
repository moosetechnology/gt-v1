Class {
	#name : #GTSpotterRequestNextStep,
	#superclass : #Announcement,
	#instVars : [
		'origin'
	],
	#category : #'GT-Spotter-Announcements'
}

{ #category : #accessing }
GTSpotterRequestNextStep >> origin [
	^ origin
]

{ #category : #accessing }
GTSpotterRequestNextStep >> origin: anObject [
	origin := anObject
]
