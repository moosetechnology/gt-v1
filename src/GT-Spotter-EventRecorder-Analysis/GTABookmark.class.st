Class {
	#name : #GTABookmark,
	#superclass : #Object,
	#instVars : [
		'item',
		'description',
		'dateAndTime',
		'garbage'
	],
	#category : #'GT-Spotter-EventRecorder-Analysis-Bookmarks'
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

{ #category : #accessing }
GTABookmark >> garbage [
	^ garbage
]

{ #category : #accessing }
GTABookmark >> garbage: aBoolean [
	garbage := aBoolean
]

{ #category : #accessing }
GTABookmark >> garbageString [
	^ self garbage
		ifTrue: 'yes'
		ifFalse: 'no'
]

{ #category : #initialization }
GTABookmark >> initialize [
	super initialize.
	dateAndTime := DateAndTime now.
	garbage := false.
]

{ #category : #testing }
GTABookmark >> isRelatedTo: anObject [ 
	^ self item = anObject 
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

{ #category : #'as yet unclassified' }
GTABookmark >> toggleGarbage [
	self garbage: self garbage not
]

{ #category : #accessing }
GTABookmark >> typeName [
	^ self subclassResponsibility
]
