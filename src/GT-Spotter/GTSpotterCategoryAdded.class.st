Class {
	#name : #GTSpotterCategoryAdded,
	#superclass : #Announcement,
	#instVars : [
		'category'
	],
	#category : #'GT-Spotter-Announcements'
}

{ #category : #accessing }
GTSpotterCategoryAdded >> category [
	^ category
]

{ #category : #accessing }
GTSpotterCategoryAdded >> category: anObject [
	category := anObject
]
