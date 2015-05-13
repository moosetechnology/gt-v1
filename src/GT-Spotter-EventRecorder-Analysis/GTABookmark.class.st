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

{ #category : #initialization }
GTABookmark >> from: aCollection computers: aGTAComputers [ 
	self subclassResponsibility
]

{ #category : #initialization }
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
