Class {
	#name : #GTExamplesModified,
	#superclass : #Announcement,
	#instVars : [
		'announcement',
		'added',
		'removed'
	],
	#category : #'GT-Examples-Utils'
}

{ #category : #public }
GTExamplesModified >> addExample: anExample [
	anExample ifNil: [ ^ self ].
	added add: anExample
]

{ #category : #public }
GTExamplesModified >> addExamples: aCollection [
	aCollection ifNil: [ ^ self ].
	aCollection do: [ :value | self addExample: value ]
]

{ #category : #accessing }
GTExamplesModified >> announcement [
	^ announcement
]

{ #category : #accessing }
GTExamplesModified >> announcement: anObject [
	announcement := anObject
]

{ #category : #initializing }
GTExamplesModified >> initialize [
	super initialize.
	
	added := OrderedCollection new: 100.
	removed := OrderedCollection new: 100.
]

{ #category : #testing }
GTExamplesModified >> isEmpty [
	^ added isEmptyOrNil 
		or: [ removed isEmptyOrNil ]
]

{ #category : #public }
GTExamplesModified >> removeExample: anExample [
	anExample ifNil: [ ^ self ].
	removed add: anExample
]

{ #category : #public }
GTExamplesModified >> removeExamples: aCollection [
	aCollection ifNil: [ ^ self ].
	aCollection do: [ :value | self removeExample: value ]
]
