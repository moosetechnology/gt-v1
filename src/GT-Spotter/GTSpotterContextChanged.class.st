Class {
	#name : #GTSpotterContextChanged,
	#superclass : #Announcement,
	#instVars : [
		'context',
		'previousContext'
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

{ #category : #accessing }
GTSpotterContextChanged >> previousContext [
	^ previousContext
]

{ #category : #accessing }
GTSpotterContextChanged >> previousContext: anObject [
	previousContext := anObject
]

{ #category : #'accessing-dynamic' }
GTSpotterContextChanged >> previousQuery [
	^ self previousContext 
		ifNil: [ '' ] 
		ifNotNil: [ :aContext | aContext text ] 
]

{ #category : #'accessing-dynamic' }
GTSpotterContextChanged >> text [
	^ self context ifNotNil: [ self context text ]
]
