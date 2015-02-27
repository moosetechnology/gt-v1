Class {
	#name : #GTSpotterContextChanged,
	#superclass : #Announcement,
	#instVars : [
		'context'
	],
	#category : #'GT-Spotter-Announcements'
}

{ #category : #accessing }
GTSpotterContextChanged >> context [
	^ context
]

{ #category : #accessing }
GTSpotterContextChanged >> context: anObject [
	context := anObject
]

{ #category : #'accessing-dynamic' }
GTSpotterContextChanged >> text [
	^ self context ifNotNil: [ self context text ]
]
