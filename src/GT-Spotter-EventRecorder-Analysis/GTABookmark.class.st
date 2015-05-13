Class {
	#name : #GTABookmark,
	#superclass : #Object,
	#instVars : [
		'item',
		'description',
		'dateAndTime'
	],
	#category : #'GT-Spotter-EventRecorder-Analysis-Core'
}

{ #category : #'as yet unclassified' }
GTABookmark class >> from: aCollection [ 
	^ aCollection first new from: aCollection; yourself
]

{ #category : #accessing }
GTABookmark >> dateAndTime [
	^ dateAndTime
]

{ #category : #accessing }
GTABookmark >> dateAndTime: anObject [
	dateAndTime := anObject
]

{ #category : #accessing }
GTABookmark >> description [
	^ description
]

{ #category : #accessing }
GTABookmark >> description: anObject [
	description := anObject
]

{ #category : #'as yet unclassified' }
GTABookmark >> from: aCollection [ 
	self subclassResponsibility
]

{ #category : #'as yet unclassified' }
GTABookmark >> initialize [
	super initialize.
	dateAndTime := DateAndTime now.
]

{ #category : #accessing }
GTABookmark >> item [
	^ item
]

{ #category : #accessing }
GTABookmark >> item: anObject [
	item := anObject
]

{ #category : #accessing }
GTABookmark >> path [
	^ self subclassResponsibility.
]
