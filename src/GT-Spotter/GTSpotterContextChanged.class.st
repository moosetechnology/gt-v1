Class {
	#name : #GTSpotterContextChanged,
	#superclass : #Announcement,
	#instVars : [
		'context',
		'previousQuery'
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

{ #category : #initialization }
GTSpotterContextChanged >> initialize [
	super initialize.
	previousQuery := ''.
]

{ #category : #accessing }
GTSpotterContextChanged >> previousQuery [
	^ previousQuery
]

{ #category : #accessing }
GTSpotterContextChanged >> previousQuery: aText [
	previousQuery := aText
]

{ #category : #'accessing-dynamic' }
GTSpotterContextChanged >> text [
	^ self context ifNotNil: [ self context text ]
]
