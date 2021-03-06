"
I am an announcement announcing that an example method was modified.

I am particularly useful for allowing tools to refresh their state if something happens with an example.
"
Class {
	#name : #GTExamplesModifiedAnnouncement,
	#superclass : #Announcement,
	#instVars : [
		'announcement',
		'added',
		'removed'
	],
	#category : #'GT-Examples-Announcements'
}

{ #category : #public }
GTExamplesModifiedAnnouncement >> addExample: anExample [
	anExample ifNil: [ ^ self ].
	added add: anExample
]

{ #category : #public }
GTExamplesModifiedAnnouncement >> addExamples: aCollection [
	aCollection ifNil: [ ^ self ].
	aCollection do: [ :value | self addExample: value ]
]

{ #category : #accessing }
GTExamplesModifiedAnnouncement >> announcement [
	^ announcement
]

{ #category : #accessing }
GTExamplesModifiedAnnouncement >> announcement: anObject [
	announcement := anObject
]

{ #category : #initializing }
GTExamplesModifiedAnnouncement >> initialize [
	super initialize.
	
	added := OrderedCollection new: 100.
	removed := OrderedCollection new: 100.
]

{ #category : #testing }
GTExamplesModifiedAnnouncement >> isEmpty [
	^ added isEmptyOrNil 
		or: [ removed isEmptyOrNil ]
]

{ #category : #public }
GTExamplesModifiedAnnouncement >> removeExample: anExample [
	anExample ifNil: [ ^ self ].
	removed add: anExample
]

{ #category : #public }
GTExamplesModifiedAnnouncement >> removeExamples: aCollection [
	aCollection ifNil: [ ^ self ].
	aCollection do: [ :value | self removeExample: value ]
]
