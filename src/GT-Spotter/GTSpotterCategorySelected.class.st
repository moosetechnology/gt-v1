Class {
	#name : #GTSpotterCategorySelected,
	#superclass : #Announcement,
	#instVars : [
		'category'
	],
	#category : #'GT-Spotter-Announcements'
}

{ #category : #accessing }
GTSpotterCategorySelected >> category [
	^ category
]

{ #category : #accessing }
GTSpotterCategorySelected >> category: anObject [
	category := anObject
]
