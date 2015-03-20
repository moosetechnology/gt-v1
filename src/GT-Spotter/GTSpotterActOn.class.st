Class {
	#name : #GTSpotterActOn,
	#superclass : #Announcement,
	#instVars : [
		'element',
		'event'
	],
	#category : #'GT-Spotter-Announcements'
}

{ #category : #accessing }
GTSpotterActOn >> element [
	^ element
]

{ #category : #accessing }
GTSpotterActOn >> element: anObject [
	element := anObject
]

{ #category : #accessing }
GTSpotterActOn >> event [

	^ event
]

{ #category : #accessing }
GTSpotterActOn >> event: anEvent [

	event := anEvent
]
